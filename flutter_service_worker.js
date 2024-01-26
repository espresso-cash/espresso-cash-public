'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "7169b38c8e6b61a570c9c4d5941251d2",
"splash/loader.css": "ce2baada6eae47b203bf23ddeceff26f",
"splash/main.css": "bee2abc28fc4c56461042c448c2799b3",
"splash/img/light-2x.png": "aecf0a6a3e55f44cae41e89b3763efe0",
"splash/img/dark-4x.png": "c406b674e75406ad1e92d417c25ebcf0",
"splash/img/light-3x.png": "b327ef0ec68590554cc9920d13b15f51",
"splash/img/dark-3x.png": "b327ef0ec68590554cc9920d13b15f51",
"splash/img/light-4x.png": "c406b674e75406ad1e92d417c25ebcf0",
"splash/img/dark-2x.png": "aecf0a6a3e55f44cae41e89b3763efe0",
"splash/img/dark-1x.png": "f7b335f6435342ece30ef619d4b4a0f8",
"splash/img/light-1x.png": "f7b335f6435342ece30ef619d4b4a0f8",
"index.html": "f518ba8d5b95c060cdf20e7d1ca99e97",
"/": "615eae9f1a90eee525096501da23ee75",
"CNAME": "9256353850d8405d67687ed8207896ac",
"main.dart.js": "d94e3fb1e2a71718ecfd29beb29ca54f",
".well-known/apple-app-site-association": "93c645ea2edd8dc54351a77c21b22099",
".well-known/assetlinks.json": "bf8e3d8ccf7b2ff8082f87f421bdc9b5",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"favicon.png": "a728f7fd9052b1f3d7e154c0c986c297",
"icons/Icon-192.png": "b17ffa40edf000c32b1855de3194cca5",
"icons/Icon-512.png": "b88a4a4e066037e9764b809eddbf615b",
"manifest.json": "8e983bfdd268d18915febd65557a8d33",
"assets/AssetManifest.json": "10143be73bba9e0646549ea302394d90",
"assets/NOTICES": "bde37bd091c471029c18dcf82de876df",
"assets/FontManifest.json": "34541a352f617d0da719f70e3d567d45",
"assets/AssetManifest.bin.json": "303b55d43f8f883262d472a2c6e84460",
"assets/packages/golden_toolkit/fonts/Roboto-Regular.ttf": "ac3f799d5bbaf5196fab15ab8de8431c",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "ffd063c5ddbbe185f778e7e41fdceb31",
"assets/packages/storybook_flutter/assets/README.md": "fbaed1ae60d80596d99545ef45d72803",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "61f525f4ac4ba8bdc577fd18edaddc57",
"assets/fonts/MaterialIcons-Regular.otf": "32fce58e2acb9c420eab0fe7b828b761",
"assets/assets/landing/appstore.png": "87bd4b198c867b8a1ff60c8166dbafa3",
"assets/assets/landing/playstore.png": "87652200b60cdb18edf438b4c632fd3a",
"assets/assets/images/logo-dark.png": "737f8c6244ad82c25f6cf551395b9f67",
"assets/assets/images/switch-currency.svg": "ab295041116d49b156c6ff4276b5561d",
"assets/assets/images/flash-on.svg": "62a66cd4e01ddb67673fbdec13044cb1",
"assets/assets/images/qr-frame.svg": "872ef2645cb7d242f7040cfb736577ba",
"assets/assets/images/dollar_bg.png": "02865844014069ef082f54709264c33e",
"assets/assets/images/logo-icon.png": "33b32103fa54964e5ea65af18854b833",
"assets/assets/images/cash_out_graphic.png": "06824e76e6ce7b11dd06a06cd3caa711",
"assets/assets/images/send_manual_bg.png": "fc641da6f367001170b4a0c48dd2bf71",
"assets/assets/images/blank.png": "945585e4d33e83ab9906050d7c004c90",
"assets/assets/images/token-logo.png": "4ed437c5ba34ae4a8f9fd60e7765a472",
"assets/assets/images/quiz_intro-bg.png": "d6b4d1c1726afa3e061d3b754393cb23",
"assets/assets/images/cash_in_graphic.png": "461305496e9e740cc2c049b02597519b",
"assets/assets/images/identity_graphic.png": "ccd84f30b546f9bc23c328ff54b002fe",
"assets/assets/images/investing-banner.png": "cce4d84eae3ae4dda99014955d640fb6",
"assets/assets/images/cash_out_bg.png": "97a49c75a985008f2796c055899a6beb",
"assets/assets/images/carousel-4.png": "f46e779116b7cf6bb275e7b27bea7a23",
"assets/assets/images/logo.png": "89f1ab7caac6eb01db44448074ed1ee9",
"assets/assets/images/carousel-1.png": "1253de9308423352ac0c95f55154eca9",
"assets/assets/images/send_money_graphic.png": "7bb27b95c6ed22c8bbb78eb1a763240d",
"assets/assets/images/cash_in_bg.png": "ab4255ba706adb168c250aaff718bbdd",
"assets/assets/images/carousel-3.png": "f4eeac4069f9777b05c4e458ee09148f",
"assets/assets/images/logo-android12.png": "f76ee19ae78921d798b46384ac69f292",
"assets/assets/images/carousel-2.png": "2240de5f0c0c9c4281e909ba9e5c82c5",
"assets/assets/images/quiz-question-bg.png": "51786b00e1c9f80e2276722e23070b93",
"assets/assets/images/flash-off.svg": "2b6692b87e925dfb81af2ca01aa550f3",
"assets/assets/images/send_money_bg.png": "64de0676b7cd791971d54c5879d1f8a8",
"assets/assets/images/2x/cash_out_graphic.png": "090b8a2abe69f0218eda1ba0ace48241",
"assets/assets/images/2x/cash_in_graphic.png": "e369374b1c227e64a8c36df68d083e47",
"assets/assets/images/2x/identity_graphic.png": "5ddbe1c2cf433f8425be18d4e136a233",
"assets/assets/images/2x/cash_out_bg.png": "7fa5c35a19e946660793de9e00aa2361",
"assets/assets/images/2x/cash_in_bg.png": "6410046b5855339e6754363f3eb82d33",
"assets/assets/images/image-picker-icon.svg": "265159359d5c7476f235441a69c22db9",
"assets/assets/coinflow/favicon.ico": "1e6a228bc3b1be06c0eeeaec76c47e50",
"assets/assets/coinflow/index.html": "615eae9f1a90eee525096501da23ee75",
"assets/assets/coinflow/asset-manifest.json": "65b4702241aef3e2c9d68b91f8a1cdcb",
"assets/assets/coinflow/static/css/main.b5d7fea6.css": "471ffac3ef5e12833f4e2ce9b0d3335e",
"assets/assets/coinflow/static/js/main.2e2aa599.js": "e1fac789279a5525c3b552794c16ffd3",
"assets/assets/coinflow/manifest.json": "a814ca588fb824dd8af9a1d9c734598b",
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
"assets/assets/icons/timeline-check.svg": "025e11e0a21377d81506d80bd1fe603f",
"assets/assets/icons/lock.svg": "9f20d9f4632e4a3b22bf574da386cdf3",
"assets/assets/icons/timeline-fail.svg": "0a4a83a657f7e5f935fd365aabd48cfb",
"assets/assets/icons/logo_bg.svg": "4f245822e7a93c26e11bc75976e8f0c4",
"assets/assets/icons/tx-failed.svg": "590d810fceb7af57bb54cc62d8e0cd0e",
"assets/assets/icons/successCheck.svg": "34e22de0867227d555a7a5c8df796f3d",
"assets/assets/icons/wallet.svg": "8bfa81c316ad689a80c252f821764d56",
"assets/assets/icons/successCheck2.svg": "65cee158e96e9d2a874f7ea8877f812e",
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
"assets/assets/icons/fail-icon.svg": "0efd84ee9f0b33e0bbfb7178a8a2229b",
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
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
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
