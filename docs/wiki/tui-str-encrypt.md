Description:
------------

This little coding helper could be used compare encrypted string/hash with a given value.

Examples:
---------
Comparing with an md5 is quite easy, as it is the preset:

	tui-str-encrypt "test string"

Will return:

	f299060e0383392ebeac64b714eca7e3
	
For an sha256 you could use:

	tui-str-encrypt -t 256 "test string"
	
And it will return:

	37d2046a395cbfcb2712ff5c96a727b1966876080047c56717009dbbc235f566

You can encrypt even multiple strings at once and parse them:

	C=0
	for E in $(tui-str-encrypt -t 512 "test string" "some thing else")
	do 	((C++))
		printf "\r$C : $E\n"
	done

Will output as:

	1 : eefda4100e361b833211365526ff1c136cc7e8635af4595faf7feae40c0082bbd85a73e80ab1c2b84ff79283125a5a5ef760aa27fbb57a39c14893af337468d8
	2 : 4f908ad2125d506cba150ec7a8e6fb177d2a1886a22d33d1a7b0dce698914076137ca033e82fba93b96b11460fbce92b3b300db21ac27bcdb8c2c9c73d47bf41

However, it already provides a verbose options:

	tui-str-encrypt -vt 512 -t md5 "test string" "some thing else"
	
Prints similar to:

	# |                       Encrypting: "test string"                        | #
	# | sha512sum:                                                             | #
	# |       eefda4100e361b833211365526ff1c136cc7e8635af4595faf7feae40c0082bb | #
	# |       d85a73e80ab1c2b84ff79283125a5a5ef760aa27fbb57a39c14893af337468d8 | #
	# | md5sum:                               f299060e0383392ebeac64b714eca7e3 | #
	# |                     Encrypting: "some thing else"                      | #
	# | sha512sum:                                                             | #
	# |       4f908ad2125d506cba150ec7a8e6fb177d2a1886a22d33d1a7b0dce698914076 | #
	# |       137ca033e82fba93b96b11460fbce92b3b300db21ac27bcdb8c2c9c73d47bf41 | #
	# | md5sum:                               8150253565a63cd1b165294ec1159884 | #
