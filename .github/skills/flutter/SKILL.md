---
name: flutter-dart-best-practices
description: "Use when: debugging Flutter/Dart issues, optimizing performance, implementing widgets, managing state with Riverpod, or working with async code and error handling."
---

# Flutter & Dart Best Practices for Chakula Mobile

## State Management with Riverpod

### Creating Providers

**Simple values:**
```dart
final userNameProvider = Provider<String>((ref) => 'John Doe');
```

**Mutable state with logic:**
```dart
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);
  
  void increment() => state++;
  void decrement() => state--;
}
```

**Async data (API calls):**
```dart
final userDataProvider = FutureProvider<User>((ref) async {
  final apiClient = ref.read(apiClientProvider);
  final response = await apiClient.get('/user');
  return User.fromJson(response);
});
```

### Consuming Providers in Widgets

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(userDataProvider);
    
    return data.when(
      data: (user) => Text(user.name),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
```

## API Client Patterns

### Making Authenticated Requests
```dart
final apiClient = ref.read(apiClientProvider);

// GET request
final response = await apiClient.get('/endpoint');

// POST request with body
final response = await apiClient.post('/endpoint', {
  'key': 'value',
});

// Unauthenticated request
final response = await apiClient.get('/public-endpoint', authenticated: false);
```

### Handling Errors
```dart
try {
  final response = await apiClient.get('/endpoint');
  return response;
} on Exception catch (e) {
  // Handle timeout, connection, or parsing error
  print('Error: $e');
  rethrow;
}
```

## Async & Await

### Avoid "Async Hell"
❌ **Bad:**
```dart
Future<void> loadData() async {
  apiClient.get('/users').then((users) {
    apiClient.get('/posts').then((posts) {
      // nested callbacks
    });
  });
}
```

✅ **Good:**
```dart
Future<void> loadData() async {
  final users = await apiClient.get('/users');
  final posts = await apiClient.get('/posts');
  // use users and posts
}
```

## Widget Best Practices

### Keep Widgets Focused
✅ Extract smaller widgets:
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: const FoodList(),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
```

### Use `const` Constructors
```dart
const AppBar(
  title: Text('Chakula'),
  // ...
);
```

### Avoid Rebuilds with StatelessWidget + Riverpod
Use `ConsumerWidget` instead of `StatefulWidget` + Riverpod:

```dart
class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Text(user.name);
  }
}
```

## Error Handling Best Practices

### Always Handle Async Errors
```dart
final data = ref.watch(dataProvider);

return data.when(
  data: (value) => displayData(value),
  loading: () => const Loader(),
  error: (error, stackTrace) {
    // Log error for debugging
    print('Error: $error');
    return ErrorWidget(message: error.toString());
  },
);
```

### Custom Error Classes
```dart
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  ApiException(this.message, [this.statusCode]);
  
  @override
  String toString() => message;
}
```

## Performance Tips

### Minimize Rebuilds
- Use `Provider` instead of `StateNotifierProvider` when state doesn't change
- Use `select()` to watch only what you need:
```dart
final userName = ref.watch(userProvider.select((user) => user.name));
```

### Lazy Load Data
```dart
final lazyDataProvider = FutureProvider<Data>((ref) async {
  // Only fetches when watched
  return ApiClient().fetchData();
});
```

### Image Caching
```dart
Image.network(
  imageUrl,
  cacheHeight: 200,
  cacheWidth: 200,
);
```

## Testing Patterns

### Test Providers
```dart
test('counter increments', () {
  final container = ProviderContainer();
  final notifier = container.read(counterProvider.notifier);
  
  notifier.increment();
  
  expect(container.read(counterProvider), 1);
});
```

### Mock API Client
```dart
final mockApiClient = Provider<ApiClient>((ref) {
  return MockApiClient();
});
```

## Common Pitfalls

❌ **Don't** use `BuildContext` across async boundaries
```dart
// BAD - context may be invalid after await
await apiClient.get('/data');
ScaffoldMessenger.of(context).showSnackBar(...);
```

✅ **Do** check if widget is mounted or use ref:
```dart
// GOOD
if (!context.mounted) return;
ScaffoldMessenger.of(context).showSnackBar(...);
```

❌ **Don't** ignore FutureProvider errors
```dart
// BAD - ignores error state
final data = ref.watch(dataProvider).maybeWhen(
  data: (value) => value,
  orElse: () => null,
);
```

✅ **Do** handle loading and error states explicitly

❌ **Don't** build Widgets in providers
```dart
// BAD
final widgetProvider = Provider((ref) => Text('Hello'));
```

✅ **Do** place logic in providers, widgets display them

## Debugging Commands

```bash
# Hot reload (preserves state)
r

# Hot restart (resets state)
R

# Verbose output
flutter run -v

# Check widget tree
flutter devtools

# Analyze code
flutter analyze

# Format code
dart format .
```
