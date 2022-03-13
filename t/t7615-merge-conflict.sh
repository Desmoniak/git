#!/bin/sh
#
# Copyright (c) 2022 Cogoni Guillaume and Bressat Jonathan
#
test_description='test finding specific blobs in the revision walking'
. ./test-lib.sh

test_expect_success 'git merge conflict when untracked file and tracked file have the same name and content' '
	echo content >readme.md &&
	git add readme.md &&
	git commit -m "README" &&
	git branch B &&
	git checkout -b A &&
	echo content >file &&
	git add file &&
	git commit -m "tracked_file" &&
	git switch B &&
	echo content >file &&
	test_merge merge A
'

test_expect_failure 'git merge conflict when untracked file and tracked file have not the same content but the same name' '
	echo content >readme.md &&
	git add readme.md &&
	git commit -m "README" &&
	git branch B &&
	git checkout -b A &&
	echo content1 >file &&
	git add file &&
	git commit -m "tracked_file" &&
	git switch B &&
	echo content2 >file &&
	test_merge merge A
'

test_done