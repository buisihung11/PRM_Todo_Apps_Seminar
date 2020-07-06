# TodoApp_Seminar_PRM

A new Flutter project that create basic todo app with using firebase as database.


## Getting Started

### Add firebase to [project](https://firebase.google.com/docs/flutter/setup?platform=android#analytics-not-enabled)

#### 1. Create a Firebase project

- [ ] Create a Firebase project [console](https://console.firebase.google.com)

#### 2. Register your app to firebase

- [ ] Open android/app/bundle get the package name
- [ ] Click on ios (or android) icon and add the packagename
- [ ] If using authentication add certificate SHA-1

#### 3. Add a Firebase configuration file

- [ ] Download *google-service.json* move to `android/app`
- [ ] Add config like [this](https://firebase.google.com/docs/flutter/setup?platform=android#add-config-file)

#### 4. Add FlutterFire plugins

- [ ] Add needed service package of firebase to your `pubspec.yaml` file 



### Issues

#### 1. Add cloud_firestore
##### Enable multidex.

Open project/app/build.gradle and add the following lines.

defaultConfig {
    ...

    multiDexEnabled true
}
and

dependencies {
    ...

    implementation 'com.android.support:multidex:1.0.3'
}
If you have migrated to AndroidX, you'll want this instead (tip by Touré Holder):

dependencies {
    ...

    implementation 'androidx.multidex:multidex:2.0.1'
}