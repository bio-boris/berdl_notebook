plugins {
    `java`
}

repositories {
    mavenCentral()
}

dependencies {
    // This single line will fetch delta-spark and all its required transitive
    // dependencies (like delta-storage, antlr, etc.) automatically.
    runtimeOnly("io.delta:delta-spark_2.12:3.2.0")
}

// Custom task to copy all resolved JARs into one directory.
// We use "libs" for a cleaner, more intuitive path.
tasks.create<Copy>("copyLibs") {
    from(configurations.runtimeClasspath)
    into("libs")
}