# solana_mobile_client

A Flutter plugin for integrating Solana Mobile features into your Flutter apps.

## Features

- Authorize and sign transactions with Solana Mobile Wallet Adapter
- Request airdrops and check wallet availability
- Support for Android (iOS has issues with MWA standards)
- Easy integration with your existing Flutter app

## Getting Started

Add this to your `pubspec.yaml`:
```yaml
dependencies:
  solana_mobile_client: ^<latest_version>
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:solana_mobile_client/solana_mobile_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Create a SolanaClient instance with testnet RPC and WebSocket endpoints
  final client = SolanaClient(
    rpcUrl: Uri.parse('https://api.testnet.solana.com'),
    websocketUrl: Uri.parse('wss://api.testnet.solana.com'),
  );

  String? address;
  bool isAuthorized = false;

  // Function to authorize the wallet using Wallet Adapter
  Future<void> authorize() async {
    final result = await client.authorize();
    setState(() {
      isAuthorized = true;
      address = result.publicKey.toBase58();
    });
  }

  // Function to deauthorize/disconnect the wallet
  Future<void> deauthorize() async {
    await client.deauthorize();
    setState(() {
      isAuthorized = false;
      address = null;
    });
  }

  // Requests an airdrop of test SOL to the connected wallet address
  Future<void> requestAirdrop() async {
    if (address == null) return;
    await client.requestAirdrop(address!);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Airdrop requested')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Solana Mobile Example')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Address: ${address ?? "Not connected"}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: authorize,
                child: const Text('Authorize Wallet'),
              ),
              ElevatedButton(
                onPressed: isAuthorized ? deauthorize : null,
                child: const Text('Deauthorize'),
              ),
              ElevatedButton(
                onPressed: isAuthorized ? requestAirdrop : null,
                child: const Text('Request Airdrop'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Screenshots

<p align="center">
  <img src="example/screenshots/solana_mobile_client_example_ss1.jpeg" alt="Home" width="45%" style="display:inline-block; margin-right:10px;" />
  <img src="example/screenshots/solana_mobile_client_example_ss2.jpeg" alt="Wallet connect modal" width="45%" style="display:inline-block;" />
</p>

<p align="center">
  <em>Left: Home screen &nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp; Right: Wallet connect modal</em>
</p>

See the [example](example/) directory for a complete sample app.

## Platform Support

- [x] Android
- [ ] iOS (coming soon)

## Contributing

Contributions are welcome! Please open issues and pull requests.


---


For more information, see the [Solana Mobile Stack documentation](https://docs.solanamobile.com/).