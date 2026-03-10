# Base image with JDK 21
FROM eclipse-temurin:21-jdk

# GUI (X11 forwarding) support
ENV DISPLAY=host.docker.internal:0

# Install dependencies
RUN apt-get update && \
    apt-get install -y maven wget unzip libgtk-3-0 libgbm1 libx11-6 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Download JavaFX SDK
RUN wget https://download2.gluonhq.com/openjfx/21/openjfx-21_linux-x64_bin-sdk.zip -O /tmp/openjfx.zip && \
    unzip /tmp/openjfx.zip -d /opt && \
    rm /tmp/openjfx.zip

WORKDIR /app

# Copy Maven build files
COPY pom.xml .
COPY src ./src

# Build the JAR
RUN mvn -q -DskipTests clean package

# Verify that calcApp.jar exists
RUN ls -l target

# Copy the fat JAR Maven produced
COPY target/calcApp.jar app.jar

# Run the JavaFX application
ENTRYPOINT ["java", "--module-path", "/opt/javafx-sdk-21/lib", "--add-modules", "javafx.controls,javafx.fxml", "-jar", "app.jar"]
