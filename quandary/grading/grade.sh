https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
#!/bin/bash

do_one_test() {
    POINTS=$1
    PROGRAM=$2
    INPUT=$3
    shift 3
    OPTIONS=$*
    echo -n "Testing $OPTIONS $PROGRAM $INPUT, worth $POINTS points: "
    # Compare the last line if process returns nonzero code; otherwise compare last two lines

    # Enable to see reference interpreter output only:
    #echo ""
    #$REF_IMPL $OPTIONS $TESTCASE_DIR/$PROGRAM $INPUT
    #echo ""
    #return

    REF_OUT=`$REF_IMPL $OPTIONS $TESTCASE_DIR/$PROGRAM $INPUT 2>&1 | tail -1`
    if [ "$REF_OUT" != "Quandary process returned 0" ]; then
      SUB_OUT=`./quandary $OPTIONS $TESTCASE_DIR/$PROGRAM $INPUT 2>&1 | tail -1`
    else
      REF_OUT=`$REF_IMPL $OPTIONS $TESTCASE_DIR/$PROGRAM $INPUT 2>&1 | tail -2`
      SUB_OUT=`./quandary $OPTIONS $TESTCASE_DIR/$PROGRAM $INPUT 2>&1 | tail -2`
    fi

    MAX_SCORE=$((MAX_SCORE + POINTS))
    if [ "$REF_OUT" == "$SUB_OUT" ]; then
      echo PASSED
      SCORE=$((SCORE + POINTS))
    else
      echo FAILED
      #echo REF_OUT is $REF_OUT # Enable for debugging
      #echo SUB_OUT is $SUB_OUT # Enable for debugging
    fi
}

if [ "$#" -ne 4 ]; then
    echo Usage: grade.sh SUBMISSION_TGZ REF_IMPL TESTCASES_FILE TESTCASE_DIR
    exit
fi

if [ -z "$JFLEX_DIR" ]; then
    echo JFLEX_DIR isn\'t set
    exit
fi
if [ -z "$CUP_DIR" ]; then
    echo CUP_DIR isn\'t set
    exit
fi

SUBMISSION_TGZ=$1

export TMPDIR=.
SUBMISSION_DIR=`mktemp -d`

# Remove tmp directory
INITIAL_DIR=`pwd`
trap "cd $INITIAL_DIR && rm -rf $SUBMISSION_DIR" EXIT

if ! [ -x "$(command -v realpath)" ]; then
  echo 'Command realpath is not installed. Trying something else, but $2 and $4 need to be relative paths for it to work!'
  REF_IMPL="../$2"
  TESTCASES_FILE="../$3"
  TESTCASE_DIR="../$4"
else
  REF_IMPL=`realpath --relative-to=$SUBMISSION_DIR $2`
  TESTCASES_FILE=`realpath --relative-to=$SUBMISSION_DIR $3`
  TESTCASE_DIR=`realpath --relative-to=$SUBMISSION_DIR $4`
fi

# Extract the submitted .tgz to a new directory
echo Extracting submission to $SUBMISSION_DIR, will perform testing there
gzip -cd "$SUBMISSION_TGZ" | tar xf - -C $SUBMISSION_DIR

# Build the submitted project
cd $SUBMISSION_DIR
make clean && make
if [[ $? -ne 0 ]] ; then
    echo WARNING: Couldn\'t run make. Is the .tgz directory structure incorrect?
    ACTUAL_MAKEFILE=`find | grep '/Makefile\|/makefile'`
    if [[ ! -f $ACTUAL_MAKEFILE ]]; then exit 1; fi
    ACTUAL=`dirname $ACTUAL_MAKEFILE`
    REF_IMPL=`realpath --relative-to=$ACTUAL $REF_IMPL`
    TESTCASES_FILE=`realpath --relative-to=$ACTUAL $TESTCASES_FILE`
    TESTCASE_DIR=`realpath --relative-to=$ACTUAL $TESTCASE_DIR`
    echo Found $ACTUAL_MAKEFILE, trying to build and execute from $ACTUAL...
    cd $ACTUAL
    make clean && make
    if [[ $? -ne 0 ]] ; then
      exit 1
    fi
fi

# Test each test case
while IFS= read -r line
do
  #echo do_one_test $line
  do_one_test $line
done < $TESTCASES_FILE

echo Total score: $SCORE out of $MAX_SCORE
