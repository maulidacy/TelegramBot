# Adding TelegramBots Library to Your NetBeans Ant Project

Your project uses Ant (build.xml), so you need to manually add the TelegramBots library JAR files to your project.

## Steps to Add TelegramBots Library

1. Download the TelegramBots JAR files:

- Visit https://mvnrepository.com/artifact/org.telegram/telegrambots
- Download the latest version of:
  - telegrambots-x.x.x.jar
  - telegrambots-meta-x.x.x.jar
  - telegrambots-abilities-x.x.x.jar (optional, if you use abilities)
- Also download dependencies if needed (e.g., slf4j-api, jackson, etc.)

2. Add JARs to your NetBeans project:

- Open your project in NetBeans.
- Right-click on the project name > Properties.
- Select "Libraries" from the categories.
- Click "Add JAR/Folder".
- Browse to the folder where you saved the downloaded JAR files.
- Select all the TelegramBots JAR files and click "Open".
- Click "OK" to close the Properties window.

3. Clean and build your project.

4. The TelegramBots classes should now be recognized, and the errors should be resolved.

## Alternative: Use Maven

If you want to switch to Maven, you can add the following dependency to your `pom.xml`:

```xml
<dependency>
    <groupId>org.telegram</groupId>
    <artifactId>telegrambots</artifactId>
    <version>6.5.0</version>
</dependency>
```

Replace `6.5.0` with the latest version.

---

If you want, I can help you with further implementation after this setup.
