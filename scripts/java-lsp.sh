#!/usr/bin/env bash

JAR="$JDTLS_HOME/plugins/org.eclipse.equinox.launcher_*.jar"

if [ "$INIT_OS_TYPE" == "macos" ]; then
	CONFIG="config_mac"
else
	CONFIG="config_linux"
fi

GRADLE_HOME_BAK=$GRADLE_HOME
unset GRADLE_HOME

GRADLE_HOME=$GRADLE_HOME_BAK/bin/gradle java \
	-Declipse.application=org.eclipse.jdt.ls.core.id1 \
	-Dosgi.bundles.defaultStartLevel=4 \
	-Declipse.product=org.eclipse.jdt.ls.core.product \
	-Dlog.protocol=true \
	-Dlog.level=ALL \
	-Xms1g \
	-Xmx2G \
	-jar $(echo "$JAR") \
	-configuration "$JDTLS_HOME/$CONFIG" \
	-data "${1:-$HOME/.jdtls}" \
	--add-modules=ALL-SYSTEM \
	--add-opens java.base/java.util=ALL-UNNAMED \
	--add-opens java.base/java.lang=ALL-UNNAMED
