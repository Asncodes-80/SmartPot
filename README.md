# Pot Supervisor App
 - Use push notification feature.
 - Use firebase analytics with core.
 - Isolated from the rest of firebase.


## Installation and use push notification feature.

In server side use from this method:
 - BaseURL is `https://fcm.googleapis.com/fcm/send` use POST.
 - Using keep-alive connection in API side.
 - Use this key to match that with device token of firebase fcm in Authorization header of request: `key=AAAAYMj0ooI:APA91bHLqUXjQjMULFnRMn_JfkYvNdBrCvH6habJYlsS3NRSpi5PQqJWDH-NymOVmCPkHm7UsJIQlg0yBXVmuAkd2Ge-OElEM38VGd5Dubriy5gKghlCP01x-BPX1vnGFl0xi62NTT8-`
 - In body of request use this format

```json
{ 
    "to": "fcm token that generate from in-app push notification",
    "notification": {
        "sound": "put sound name here",
        "title": "",
        "body": "",
        "content_available": true,
        "priority": "high"
    },
    "data": {
     "click_action": "FLUTTER_NOTIFICATION_CLICK",
     "sound": "default",
     "status": "done",
     "target": "2",
     "otherKeys": "other values"
    }
}
```
