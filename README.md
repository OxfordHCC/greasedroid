# GreaseDroid

**Note that this repository is solely meant be used for research purposes. It is NOT intended for piracy and other non-legal uses.**

<i>Authors</i>: [Konrad Kollnig](https://github.com/kasnder), [Siddhartha Datta](https://github.com/dattasiddhartha)

GreaseDroid aims to make it easier for Android users to make their apps fit their special needs. This repository provides a proof-of-concept of the paradigms behind GreaseDroid.

Before using, please change the provided signing key `release-key.keystore`.

```{bash}
keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
```

### GreaseDroid web application

#### Usage:

1. Set up `apktool`, `jre`, `python`, and fill out `data/config.csv`
2. Install Python requirements: `pip3 install -r requirements.txt `
3. Run `python3 app.py` to start patching files (deploy publicly wth `ngrok`)

### CLI Tool: testing/cli

#### Usage

1. Place apk file to be decoded, compiled and signed in the `./data/` directory
2. Run `python3 apk_parse.py --apk <apk-filename>`

### Patches: testing/patches

This project ship a range of patches that can be run by providing the path the directory with the decompiled app resources from `apktool`.

For instance, if the app `./store/com.twitter.android.apk` was decompiled into `./com.twitter.android`:

```{bash}
./patches/com.twitter.android/3_remove_status_updates.sh ./com.twitter.android
```
