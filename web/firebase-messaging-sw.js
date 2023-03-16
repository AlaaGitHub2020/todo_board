importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js");

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;


firebase.initializeApp({
     apiKey: 'AIzaSyDV-URkn-XO4Fsod5f_qZc1a061cuCEn3c',
     appId: '1:637706271251:web:ac21854efd4e144c019de6',
     messagingSenderId: '637706271251',
     projectId: 'al-asal-app',
     authDomain: 'al-asal-app.firebaseapp.com',
     databaseURL: 'https://al-asal-app-default-rtdb.firebaseio.com',
     storageBucket: 'al-asal-app.appspot.com',
     measurementId: 'G-RC51RRQXBH',
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});