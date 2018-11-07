QT += quick multimedia
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
    utility.cpp \
    cppsrc/personel.cpp

RESOURCES += qml.qrc

RC_FILE = app.rc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += $$PWD

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target



win32{
    message("* using settings for windows");

unix|win32: LIBS += -L$$PWD/mingw32-windows-release-v0.7/lib/ -lQMongoDB

INCLUDEPATH += $$PWD/mingw32-windows-release-v0.7/include
DEPENDPATH += $$PWD/mingw32-windows-release-v0.7/include
}




android{
    message("* using settings for android");

    LIBS += -L$$PWD/android-release-v0.7/libs/armeabi-v7a/ -lQMongoDB

    INCLUDEPATH += $$PWD/android-release-v0.7/include
    DEPENDPATH += $$PWD/android-release-v0.7/include

    contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
        ANDROID_EXTRA_LIBS = \
            $$PWD/android-release-v0.7/libs/armeabi-v7a/libbson-1.0.so \
            $$PWD/android-release-v0.7/libs/armeabi-v7a/libcrypto.so \
            $$PWD/android-release-v0.7/libs/armeabi-v7a/libmongoc-1.0.so \
            $$PWD/android-release-v0.7/libs/armeabi-v7a/libQMongoDB.so \
            $$PWD/android-release-v0.7/libs/armeabi-v7a/libssl.so
    }

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

}

HEADERS += \
    utility.h \
    ../url.h \
    cppsrc/personel.h

DISTFILES += \
    img/duyuru1.JPG \
    app.rc



