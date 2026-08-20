# Keep OkHttp classes for UCrop (used by image_cropper)
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**
-keep class com.yalantis.ucrop.** { *; }
-dontwarn com.yalantis.ucrop.**
