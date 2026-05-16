/* ─────────────────────────────────────────────
   家計簿 Service Worker  v2.0
   オフライン対応 + キャッシュ戦略
───────────────────────────────────────────── */
const CACHE_NAME = 'kakeibo-v19';

// キャッシュするアセット（アプリシェル）
const SHELL_ASSETS = [
  './index.html',
  'https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js',
  'https://cdnjs.cloudflare.com/ajax/libs/dexie/3.2.4/dexie.min.js'
];

// ── インストール：アプリシェルをキャッシュ
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => cache.addAll(SHELL_ASSETS))
  );
  self.skipWaiting();
});

// ── アクティベート：古いキャッシュを削除
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(
        keys
          .filter(key => key !== CACHE_NAME)
          .map(key => caches.delete(key))
      )
    )
  );
  self.clients.claim();
});

// ── フェッチ：index.htmlはNetwork-First、他はCache-First
self.addEventListener('fetch', event => {
  if (!event.request.url.startsWith('http')) return;

  const isNav = event.request.mode === 'navigate' ||
                event.request.url.endsWith('index.html');

  if (isNav) {
    // index.html: ネットワーク優先（更新を即反映）→ 失敗時はキャッシュ
    event.respondWith(
      fetch(event.request).then(response => {
        if (response && response.status === 200) {
          const clone = response.clone();
          caches.open(CACHE_NAME).then(cache => cache.put(event.request, clone));
        }
        return response;
      }).catch(() => caches.match('./index.html'))
    );
  } else {
    // CDNライブラリ等: Cache-First（オフライン対応）
    event.respondWith(
      caches.match(event.request).then(cached => {
        if (cached) return cached;
        return fetch(event.request).then(response => {
          if (response && response.status === 200 && response.type !== 'opaque') {
            const clone = response.clone();
            caches.open(CACHE_NAME).then(cache => cache.put(event.request, clone));
          }
          return response;
        });
      })
    );
  }
});
