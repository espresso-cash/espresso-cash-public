'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "95d6303ae57530a753e6fec83572695f",
"splash/splash.js": "c6a271349a0cd249bdb6d3c4d12f5dcf",
"splash/style.css": "612cfb137cdffdd3a59ca1ee1688b9d5",
"index.html": "0d6b8fd84c6d2749895e07b129073ea8",
"/": "0d6b8fd84c6d2749895e07b129073ea8",
"CNAME": "9256353850d8405d67687ed8207896ac",
"main.dart.js": "a6ee4c5237dee2bd9320bb7fe7d49e7a",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "a728f7fd9052b1f3d7e154c0c986c297",
"icons/Icon-192.png": "b17ffa40edf000c32b1855de3194cca5",
"icons/Icon-512.png": "b88a4a4e066037e9764b809eddbf615b",
"manifest.json": "8e983bfdd268d18915febd65557a8d33",
"assets/AssetManifest.json": "a5e535274bbab49f635c0691e148208b",
"assets/NOTICES": "326470c284fe570683fb8dc1c691321b",
"assets/FontManifest.json": "34541a352f617d0da719f70e3d567d45",
"assets/packages/golden_toolkit/fonts/Roboto-Regular.ttf": "ac3f799d5bbaf5196fab15ab8de8431c",
"assets/packages/storybook_flutter/assets/README.md": "fbaed1ae60d80596d99545ef45d72803",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "4d60a7001323d92828aacf8732dcf200",
"assets/fonts/MaterialIcons-Regular.otf": "51ae374a42e4c3676b3158d40e704899",
"assets/assets/landing/bg_desktop.png": "04a30815c8c10d082290000109fd1749",
"assets/assets/landing/bg_mobile.png": "7486eb98a96dafabe84156ca1e70a5db",
"assets/assets/landing/appstore.png": "87bd4b198c867b8a1ff60c8166dbafa3",
"assets/assets/landing/playstore.png": "87652200b60cdb18edf438b4c632fd3a",
"assets/assets/images/logo-dark.png": "737f8c6244ad82c25f6cf551395b9f67",
"assets/assets/images/carousel-1.5.png": "fd6f430ac739cc3a0622a1d74054ae3d",
"assets/assets/images/switch-currency.svg": "ab295041116d49b156c6ff4276b5561d",
"assets/assets/images/flash-on.svg": "62a66cd4e01ddb67673fbdec13044cb1",
"assets/assets/images/qr-frame.svg": "872ef2645cb7d242f7040cfb736577ba",
"assets/assets/images/logo-icon.png": "33b32103fa54964e5ea65af18854b833",
"assets/assets/images/cash_out_graphic.png": "06824e76e6ce7b11dd06a06cd3caa711",
"assets/assets/images/token-logo.png": "4ed437c5ba34ae4a8f9fd60e7765a472",
"assets/assets/images/cash_in_graphic.png": "461305496e9e740cc2c049b02597519b",
"assets/assets/images/identity_graphic.png": "ccd84f30b546f9bc23c328ff54b002fe",
"assets/assets/images/investing-banner.png": "5d82d59f5f8090bf43bf6985abc96c1a",
"assets/assets/images/cash_out_bg.png": "b0ac02692cfdf1f8ae87cf964d14aad8",
"assets/assets/images/logo.png": "7de9bce833a94bc64fd07c21e59e6bdb",
"assets/assets/images/carousel-1.png": "13a574a266e468a9d2e01325a8054b4b",
"assets/assets/images/cash_in_bg.png": "5be85b21993418798154806937795319",
"assets/assets/images/carousel-3.png": "81a543fde6826b59ee3344e669b588f3",
"assets/assets/images/carousel-2.png": "fae25ec9f6200b9282e036a671c9aab4",
"assets/assets/images/flash-off.svg": "2b6692b87e925dfb81af2ca01aa550f3",
"assets/assets/images/2x/cash_out_graphic.png": "090b8a2abe69f0218eda1ba0ace48241",
"assets/assets/images/2x/cash_in_graphic.png": "e369374b1c227e64a8c36df68d083e47",
"assets/assets/images/2x/identity_graphic.png": "5ddbe1c2cf433f8425be18d4e136a233",
"assets/assets/images/2x/cash_out_bg.png": "7fa5c35a19e946660793de9e00aa2361",
"assets/assets/images/2x/cash_in_bg.png": "6410046b5855339e6754363f3eb82d33",
"assets/assets/images/image-picker-icon.svg": "265159359d5c7476f235441a69c22db9",
"assets/assets/rive/onboarding-notice.riv": "0b91ac8909387db8070d6957433745c9",
"assets/assets/rive/slider.riv": "4f89a4c88fd22600f882ab0dcc4ea641",
"assets/assets/rive/header.riv": "2a2543e5832fc864d01df028299c21bb",
"assets/assets/rive/second-link.riv": "2c7443b75a63198734de3961c481a3b6",
"assets/assets/icons/tx-succeeded.svg": "bf8f5a7952a39b8806b7ca6e5c8fbe6c",
"assets/assets/icons/arrow.svg": "2e060e4251359c2dde57e8c9a8d18b14",
"assets/assets/icons/unfavorite_light.svg": "66faa00b7b905f84c971af63a1182a7d",
"assets/assets/icons/home.svg": "a7e9d6878a6e91445c2a12ad3861c251",
"assets/assets/icons/key_delete.svg": "a651c648f326a98ac33a4708f39fdc80",
"assets/assets/icons/visibility.svg": "49c413bfb4e687fd54b832e70286f589",
"assets/assets/icons/unfavorite.svg": "5a3ad96806cf4ebde0e1e166acc66ce4",
"assets/assets/icons/toastWarning.png": "a0a7783f1bef5ca75319b7037f820b31",
"assets/assets/icons/lock.svg": "9f20d9f4632e4a3b22bf574da386cdf3",
"assets/assets/icons/logo_bg.svg": "4f245822e7a93c26e11bc75976e8f0c4",
"assets/assets/icons/tx-failed.svg": "590d810fceb7af57bb54cc62d8e0cd0e",
"assets/assets/icons/successCheck.svg": "34e22de0867227d555a7a5c8df796f3d",
"assets/assets/icons/wallet.svg": "8bfa81c316ad689a80c252f821764d56",
"assets/assets/icons/receive.svg": "44b1fc19632864493394ebf7cfa7a973",
"assets/assets/icons/info.svg": "21d845a85ff099b555ac51b2a2024173",
"assets/assets/icons/add.svg": "2db569797d90544a52ca2fe82820409d",
"assets/assets/icons/success-icon.svg": "87ffcf62b64e1bd97d5eb220ca50e0cd",
"assets/assets/icons/favorite.svg": "9924b74bde43130646aee73a2ec76561",
"assets/assets/icons/send.svg": "1b9ed145fc6c9d064c8961e6c7d58b9a",
"assets/assets/icons/search-button-icon.svg": "08eaeaa40bf91284ffeb94ff82bc87a7",
"assets/assets/icons/tx-icon.svg": "1d56cde7f06fc32ae08951e582cf0403",
"assets/assets/icons/payment-icon.svg": "edb4e38294bcd6ce3b83039571c29145",
"assets/assets/icons/secret.svg": "8dfc25356863853e5f33390311a3501c",
"assets/assets/icons/profile.svg": "655e1dd5d2c405e6e95d49d0ca9c21d8",
"assets/assets/icons/twitter.svg": "d93f6f19ddbf372cf97c6f08c442f3c9",
"assets/assets/icons/notifications.svg": "670558d64b750b9947373f145cef34d8",
"assets/assets/icons/success-icon-dark-bg.svg": "0aa6ceb0ff76801b1b5c94d7fb23eee9",
"assets/assets/icons/logo_dark.svg": "554a6e6e72baa88538c2a37f655c65b6",
"assets/assets/icons/settings-button-icon.svg": "5e7ad361c36deedf26dd67761049a09d",
"assets/assets/icons/close-button-icon.svg": "b434aa2336de124dd91fcbe115ff9017",
"assets/assets/icons/close-button-icon-light.svg": "b701e82df23f04e870824acd769acde9",
"assets/assets/icons/qr_scanner.svg": "55c15d273d0977b0b8b7bbfd4ad61037",
"assets/assets/icons/swap.svg": "d1e615d83de2ab66fec33ae25d2f4ce5",
"assets/assets/fonts/Roboto-Medium.ttf": "68ea4734cf86bd544650aee05137d7bb",
"assets/assets/fonts/Roboto-Light.ttf": "881e150ab929e26d1f812c4342c15a7c",
"assets/assets/fonts/Roboto-Regular.ttf": "8a36205bd9b83e03af0591a004bc97f4",
"assets/assets/fonts/Roboto-MediumItalic.ttf": "c16d19c2c0fd1278390a82fc245f4923",
"assets/assets/fonts/Roboto-ThinItalic.ttf": "7bcadd0675fe47d69c2d8aaef683416f",
"assets/assets/fonts/Roboto-BoldItalic.ttf": "fd6e9700781c4aaae877999d09db9e09",
"assets/assets/fonts/Roboto-LightItalic.ttf": "5788d5ce921d7a9b4fa0eaa9bf7fec8d",
"assets/assets/fonts/Roboto-Italic.ttf": "cebd892d1acfcc455f5e52d4104f2719",
"assets/assets/fonts/Roboto-BlackItalic.ttf": "c3332e3b8feff748ecb0c6cb75d65eae",
"assets/assets/fonts/Roboto-Bold.ttf": "b8e42971dec8d49207a8c8e2b919a6ac",
"assets/assets/fonts/Roboto-Thin.ttf": "66209ae01f484e46679622dd607fcbc5",
"assets/assets/fonts/Roboto-Black.ttf": "d6a6f8878adb0d8e69f9fa2e0b622924",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
