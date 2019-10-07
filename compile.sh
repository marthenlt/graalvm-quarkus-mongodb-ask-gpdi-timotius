#!/usr/bin/env bash
#mvn -DskipTests clean package

export JAR="myfirstsbootapp-0.0.1-SNAPSHOT.jar"
rm -f qna
printf "Unpacking $JAR\n"
rm -rf unpack
mkdir unpack
#mkdir -p unpack/BOOT-INF/lib
#mkdir -p unpack/BOOT-INF/classes

cd unpack
jar -xvf ../target/$JAR >/dev/null 2>&1
#cp -R META-INF BOOT-INF/classes
#cp -R lib /BOOT-INF/lib

cd ../

#cd BOOT-INF/classes
export LIBPATH=/mnt/c/demo/vlogs/ask-gpdi-tomotius-sg/unpack/lib
export METAINF="unpack/META-INF"
export CP=.:$LIBPATH:$METAINF
export PWD="$(pwd)"

pwd

# This would run it here... (as an exploded jar)
#java -classpath $CP com.example.demo.DemoApplication

# Our feature being on the classpath is what triggers it
#export CP=$CP:../../../../../spring-graal-native-image-feature/target/spring-graal-native-image-feature-0.6.0.BUILD-SNAPSHOT.jar
export CP=target/$JAR:$LIBPATH

printf "\nLIBPATH = $LIBPATH\n" 
printf "\nMETAINF = $METAINF\n" 
printf "\nPWD = $PWD\n" 
printf "\nCP = $CP\n" 

printf "\n\nCompile\n"

#native-image -Dio.netty.noUnsafe=true --no-server -H:+TraceClassInitialization \
	#  -H:Name=petclinic -H:+ReportExceptionStackTraces --no-fallback \
	#  --allow-incomplete-classpath --report-unsupported-elements-at-runtime -DremoveUnusedAutoconfig=true \
	#  -cp $CP org.springframework.samples.petclinic.PetClinicApplication

native-image -H:+TraceClassInitialization -DavoidLogback=true -Ddebug=true -Dio.netty.noUnsafe=true --no-server -H:Name=qna -H:+ReportExceptionStackTraces --no-fallback --allow-incomplete-classpath --report-unsupported-elements-at-runtime -cp $CP com.gpdisingapura.timotius.ask.Application


#mv petclinic ../../..

printf "\n\nCompiled app (qna)\n"
#cd ../../..
time ./qna


