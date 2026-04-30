import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/app_colors.dart';

// ---------------------------------------------------------------------------
// Cache service
// ---------------------------------------------------------------------------

class _PrivacyCacheService {
  static const _ttl = Duration(hours: 12);
  static const _htmlFileName = 'privacy_cache.html';
  static const _metaFileName = 'privacy_cache.meta';
  static const _url = 'https://chakula.app/privacy';

  Future<Directory> get _dir => getApplicationDocumentsDirectory();

  /// Returns cached HTML if it exists and is younger than [_ttl].
  /// Returns `null` if the cache is missing or expired.
  Future<String?> _readCache() async {
    try {
      final dir = await _dir;
      final metaFile = File('${dir.path}/$_metaFileName');
      final htmlFile = File('${dir.path}/$_htmlFileName');

      if (!metaFile.existsSync() || !htmlFile.existsSync()) return null;

      final ts = int.tryParse(await metaFile.readAsString().then((s) => s.trim()));
      if (ts == null) return null;

      final cachedAt = DateTime.fromMillisecondsSinceEpoch(ts);
      if (DateTime.now().difference(cachedAt) > _ttl) return null;

      return htmlFile.readAsString();
    } catch (_) {
      return null;
    }
  }

  /// Fetches fresh HTML, writes it to disk with a new timestamp.
  Future<String> _fetchAndStore() async {
    final response = await http
        .get(Uri.parse(_url))
        .timeout(const Duration(seconds: 15));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('HTTP ${response.statusCode}');
    }

    final html = response.body;
    final dir = await _dir;
    await File('${dir.path}/$_htmlFileName').writeAsString(html);
    await File('${dir.path}/$_metaFileName')
        .writeAsString('${DateTime.now().millisecondsSinceEpoch}');
    return html;
  }

  /// Returns HTML from cache if fresh; otherwise fetches and caches it.
  /// If fetch fails but stale cache exists, returns the stale cache as fallback.
  Future<({String html, bool fromCache})> resolve() async {
    final cached = await _readCache();
    if (cached != null) return (html: cached, fromCache: true);

    try {
      final fresh = await _fetchAndStore();
      return (html: fresh, fromCache: false);
    } catch (_) {
      // network failed — try serving stale cache as a last resort
      final stale = await _staleCache();
      if (stale != null) return (html: stale, fromCache: true);
      rethrow;
    }
  }

  /// Reads the HTML file regardless of TTL (stale fallback).
  Future<String?> _staleCache() async {
    try {
      final dir = await _dir;
      final htmlFile = File('${dir.path}/$_htmlFileName');
      return htmlFile.existsSync() ? htmlFile.readAsString() : null;
    } catch (_) {
      return null;
    }
  }

  /// Forces a fresh fetch and updates the cache. Used by the reload button.
  Future<String> forceRefresh() => _fetchAndStore();
}

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  static const _baseUrl = 'https://chakula.app';

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  final _cache = _PrivacyCacheService();
  late final WebViewController _controller;

  // tri-state: null = loading, true = loaded, false = error
  bool? _loaded;
  bool _fromCache = false;
  bool _webViewProgress = false; // true while WebView renders html

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.background)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (_) => setState(() => _webViewProgress = true),
        onPageFinished: (_) => setState(() => _webViewProgress = false),
      ));
    _load();
  }

  Future<void> _load({bool forceRefresh = false}) async {
    setState(() {
      _loaded = null; // show our own loading spinner
      _fromCache = false;
    });
    try {
      final result = forceRefresh
          ? (html: await _cache.forceRefresh(), fromCache: false)
          : await _cache.resolve();

      await _controller.loadHtmlString(
        result.html,
        baseUrl: PrivacyScreen._baseUrl,
      );
      if (mounted) {
        setState(() {
          _loaded = true;
          _fromCache = result.fromCache;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loaded = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            if (_loaded == true && _fromCache)
              Text(
                'Cached · refreshes every 12 h',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
          ],
        ),
        centerTitle: false,
        actions: [
          if (_loaded != null)
            IconButton(
              icon: const Icon(Icons.refresh_rounded, size: 22),
              color: AppColors.textSecondary,
              tooltip: 'Force refresh',
              onPressed: () => _load(forceRefresh: true),
            ),
          const SizedBox(width: 4),
        ],
        bottom: _webViewProgress
            ? const PreferredSize(
                preferredSize: Size.fromHeight(3),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primary),
                  minHeight: 3,
                ),
              )
            : null,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return switch (_loaded) {
      null => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      false => _buildErrorView(),
      true => WebViewWidget(controller: _controller),
    };
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.toastError.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                size: 40,
                color: AppColors.toastError,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Could not load page',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Check your internet connection and try again.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: () => _load(),
              icon: const Icon(Icons.refresh_rounded),
              label: Text(
                'Try Again',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
