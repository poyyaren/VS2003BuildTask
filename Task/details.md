# Build Visual Studio .NET 2008

A build task to build Visual Studio .NET 2008 applications. 

Even though this version of Visual Studio is [no longer supported by Microsoft](https://support.microsoft.com/en-us/lifecycle/search?sort=PN&alpha=Visual%20Studio%202008 ), there are many enterprises that still have legacy applications that run in this platform. Probably are applications so stable that don't worth the migration effort or, maybe, the migration schedule are so long that an immediate build automation for the 2008 version is necessary.

The task builds Desktop Applications. The build process consists basically in call the Visual Studio 2008 application (DevEnv.exe) passing a solution file (\*.sln) or a project file (\*.\*proj).

The task requires the 'VS90COMNTOOLS' capability from the agent. This capability is normally available when Visual Studio 2008 is installed on the agent machine.  
