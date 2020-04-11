'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "a781886fba4089e76350403b817542f7",
"assets/assets/flare/app_background.flr": "ecb41960871fb48dc154348db2d7c884",
"assets/assets/flare/corona_pink_logo.flr": "86a06cd1b9f67bff11035bdff2101f29",
"assets/FontManifest.json": "f7161631e25fbd47f3180eae84053a51",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/LICENSE": "79486c3631d7ddc7ea4207dffa8c0a34",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "5dfc4b8e7505f6bcb4fb489b20b3519c",
"/": "5dfc4b8e7505f6bcb4fb489b20b3519c",
"main.dart.js": "2bab3e1ae98b6e39ce49d3e1d2c08088",
"manifest.json": "d882f9db0b2d2a9f55d4ecc26c45df4f"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
