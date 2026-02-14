
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Fix for Isar namespace issue with newer AGP
subprojects {
    afterEvaluate {
        // Fix for Isar namespace issue with newer AGP
        if (project.name == "isar_community_flutter_libs") {
             try {
                 val android = project.extensions.getByName("android") as com.android.build.gradle.BaseExtension
                 if (android.namespace == null) {
                     android.namespace = "dev.isar.isar_flutter_libs"
                 }
             } catch (e: Exception) {
                 // Ignore if android extension is not found
             }
        }
        
        // Force compileSdk and targetSdk for all subprojects to fix library compatibility issues
        // Skip the main app module as it has its own configuration
        if (project.hasProperty("android") && project.name != "app") {
            try {
                val android = project.extensions.getByName("android") as com.android.build.gradle.BaseExtension
                android.compileSdkVersion(34)
                android.defaultConfig.targetSdkVersion(34)
            } catch (e: Exception) {
                 // Ignore if android extension is not found or compatible
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
