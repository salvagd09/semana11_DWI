#!/usr/bin/env bash
set -e
echo "======================================"
echo " GENERADOR DE APK - ANGULAR / IONIC"
echo "======================================"
PROJECT_DIR="$(pwd)"
APK_NAME="mi-app-debug.apk"
echo "Proyecto actual: $PROJECT_DIR"
echo "1. Instalando dependencias npm..."
npm install
echo "2. Compilando proyecto..."
npm run build
echo "3. Instalando Capacitor Android..."
#npm  install @capacitor/android --save
npm install @capacitor/core @capacitor/android
echo "4. Agregando o sincronizando Android..."
if [ -d "android" ]; then
echo "La carpeta android ya existe. Sincronizando..."
npx cap sync android
else
echo "La carpeta android no existe. Creando..."
npx cap add android
npx cap sync android
fi
echo "5. Instalando Java 21 y herramientas necesarias..."
sudo apt-get update
sudo apt-get install -y openjdk-21-jdk wget unzip
echo "6. Configurando Java 21..."
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
java -version
javac -version
echo "7. Instalando Android SDK..."
export ANDROID_HOME=$HOME/android-sdk
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH
mkdir -p $ANDROID_HOME/cmdline-tools
if [ ! -f "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" ]; then
echo "Descargando Android Command Line Tools..."
cd /tmp
rm -rf cmdline-tools commandlinetools-linux-11076708_latest.zip
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip commandlinetools-linux-11076708_latest.zip
mkdir -p $ANDROID_HOME/cmdline-tools/latest
mv cmdline-tools/* $ANDROID_HOME/cmdline-tools/latest/
else
echo "Android SDK ya está instalado."
fi
mkdir -p $ANDROID_HOME/cmdline-tools
if [ ! -f "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" ]; then
echo "Descargando Android Command Line Tools..."
cd /tmp
rm -rf cmdline-tools commandlinetools-linux-11076708_latest.zip
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip commandlinetools-linux-11076708_latest.zip
mkdir -p $ANDROID_HOME/cmdline-tools/latest
mv cmdline-tools/* $ANDROID_HOME/cmdline-tools/latest/
else
echo "Android SDK ya está instalado."
fi
echo "8. Aceptando licencias de Android..."
yes | sdkmanager --licenses || true
echo "9. Instalando paquetes Android necesarios..."
sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0"
echo "10. Configurando local.properties..."
cd "$PROJECT_DIR/android"
echo "sdk.dir=$ANDROID_HOME" > local.properties
echo "11. Generando APK..."
chmod +x gradlew
./gradlew --stop
./gradlew clean
./gradlew assembleDebug
echo "12. Copiando APK a la raíz del proyecto..."
cd "$PROJECT_DIR"
cp android/app/build/outputs/apk/debug/app-debug.apk ./$APK_NAME
