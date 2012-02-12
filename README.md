PART A - Prepare image and adjust build scripts
===============================================

Install the support scripts, either by downloading the latest code directly from GitHub http://github.com/renggli/builder/zipball/master or by cloning the Git repository:

	git clone git://github.com/renggli/builder.git
	
You should get a directory structure with several empty directories, this readme file and several shell scripts.

1. Get a distribution image from http://www.pharo-project.org/pharo-download and unzip the image in the "images" directory. You can also script that in your initial build-step and fetch the official stable images from http://pharo-project.org/pharo-download/stable-core or http://pharo-project.org/pharo-download/stable.

2. Review or create your own build scripts in the directory "scripts". Use whatever loader you want: Gofer, Metacello, Mason, ... There are two special scripts, "before.st" is run prior to any build and "after.st" is run after any build. Make sure that the last action of the "after.st" script saves and quits the image. The other scripts load stuff and set settings. The sample builds scripts are a good starting point for creating your own build scripts for your own projects.

3. The "cache" directory contains the package cache of the builds. It is initially empty.

4. The "builds" directory is only used when the build script is called from the command-line. When used from Jenkins it remains empty.

5. The "sources" directory contains the .sources files that your images might need. Available sources files are linked to the build directory if present.

6. The "oneclick" directory contains a template for building oneclick images. "oneclick-icons" contains a collection of icons to be used with the oneclick images.

The generic build script build.sh works on this directory structure. Also the other shell scripts expect the structure like this. Preferably these scripts are called from Jenkins, but you can also call it from the command line. build.sh takes 3 kinds of arguments, an input image name, an output image name, and a series of scripts to load into that image. See the help for details.

Similary build-oneclick.sh takes and input image and builds a one-click image from it. Run the script without any arguments to get a listing of supported settings.

PART B - Integrate with Jenkins
===============================

- download "jenkins.war" from http://jenkins-ci.org/
- start the Jenkins server
- add build.sh to your path, so that can be easily called from within Jenkins
- run Jenkins with something like:

        WARFILE=$HOME/apps/jenkins/jenkins.war
        LOGFILE=jenkins.log
        nohup java -jar $WARFILE --httpPort=9090 > $LOGFILE 2>&1 &
- port 9090 is used to avoid conflict with Seaside on 8080
- goto the Jenkins dashboard at http://localhost:9090/

Add new Jenkins job
-------------------
- from Jenkins dashboard, select "New Job"
- fill in a job name, e.g. "Pharo"
- choose the "Build as free-style software project" radio button
- click on OK

Configure the new job
---------------------
- you should be sent to the job configuration screen, after the previous step
- in the "Build" section, click "Add build step", select "Execute shell" from dropdown menu
- in the command textarea that appears, type the build specification:

        build.sh -i PharoCore-1.0-10505rc1 -s omnibrowser -o omnibrowser
        build.sh -i omnibrowser -s buildtools -s omnibrowser-tests -o omnibrowser-tests

        build-oneclick.sh -i omnibrowser -o Pharo-OneClick -n Pharo -t "Pharo Development" -v 1.1 -c Pharo
- in the "Post-build Actions" section, enable "Publish JUnit test result report"
- enter "**/*-Test.xml" into the text input labelled "Test report XMLs" that appears.
- in the "Post-build Actions" section, enable "Publish Checkstyle analysis results" (requires the Checkstyle plugin to be installed)
- enter "**/*-Lint.xml" into the text input labelled "Checkstyle results"

- in the "Post-build Actions" section, enable "Record Emma coverage report" (requires the Jenkins Emma plugin to be installed)
- enter "**/*-Coverage.xml" into the text input labelled "Folders or files containing Emma XML reports"
- in the "Post-build Actions" section, enable "Archive the artifacts"
- enter the "Files to archive" as "**/*.image, **/*.changes, **/*.zip"
- save the configuration changes.

Run the build job
-----------------
- after saving the new job, you should already be in the new job's control screen. If not, you can navigate there from the dashboard.
- start a build by clicking on the "Build Now" link

DEBUGGING
=========

1. Test your build scripts in a headful image beforehand.

2. In case of problems study the "Console Output" of the failed build.

3. In most cases builds fail because of an error within the image. Click on "Workspace" and check "PharoDebug.log".

4. If the build stalls abort it and study the "Console Output" to figure out what went wrong.

JENKINS PLUGINS
===============

- The "URL Change Trigger" plugin is useful to automatically trigger builds when the Monticello repository changes.

- The "Checkstyle Plug-in" reports lint errors in Jenkins.

- The "Jenkins Emma plugin" reports test coverage in Jenkins.

- The "Green Balls" plugin makes the Jenkins GUI look slightly better.

- The "Google Analytics Plugin" tracks users of Jenkins.
