alias l=bat
alias ll='ls -l'
alias fl='find-less.sh'
alias fec='find-ec.sh'
alias ec=emacsclient
alias cleanem="find . -name '*~' -exec rm {} \;"
alias dirs='dirs -v'
alias chrome='google-chrome'

alias jack='ack --java'
alias jsack='ack --js'
alias tsack='ack --ts'
alias gack='ack --groovy'

alias f='find . -name'
alias fix=fix-scripts.sh

alias java7='. ~/bin/setup-java-1.7.sh'
alias java8='. ~/bin/setup-java-1.8.sh'

alias build='(   export MAVEN_OPTS="-Dmaven.test.skip=true" ; mvn  -U package )'
alias ibuild='(  export MAVEN_OPTS="-Dmaven.test.skip=true" ; mvn  -U install )'
alias cibuild='( export MAVEN_OPTS="-Dmaven.test.skip=true" ; mvn  -U clean   install )'
alias cbuild='(  export MAVEN_OPTS="-Dmaven.test.skip=true" ; mvn  -U clean   package )'
alias rbuild=release-build.sh

alias deps='(     export MAVEN_OPTS="-Dmaven.test.skip=true" ; mvn  dependency:analyze )'
alias depstree='( export MAVEN_OPTS="-Dmaven.test.skip=true" ; mvn  dependency:tree    )'

alias decompile='java -jar ~/Tools/jd-gui-1.4.0.jar &'
alias jf=jformat.sh

alias ff="find . -type f -a -not -path '*/\.*'"

alias editproxy='dconf-editor'

alias ju=junit.sh

#-- git ---------------------------------
alias gs='git status'
alias gd='git diff --ignore-all-space --ignore-blank-lines --ignore-space-change --ignore-space-at-eol --ignore-cr-at-eol'
alias gclone=gclone.sh

#-- npm, ng ---------------------------------
alias ngs='ng serve --host 0.0.0.0'

#-- Markdown ---------------------------------
alias md=/home/jhalliley/.local/bin/grip
