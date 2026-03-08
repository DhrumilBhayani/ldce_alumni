importScripts(
  "https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js",
);
importScripts(
  "https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js",
);

firebase.initializeApp({
  apiKey: "AIzaSyBLUBFJqyJKBZzr-WFgn_IZQdx5U9xNYxA",
  appId: "1:560097527000:web:81b3a97aaf0a332f9ac3ad",
  messagingSenderId: "560097527000",
  projectId: "ldce-alumni-bd8d4",
  storageBucket: "ldce-alumni-bd8d4.appspot.com",
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((message) => {
  console.log("Background message received:", message);
});
