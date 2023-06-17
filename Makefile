build:
	clang kyoto.cpp -lstdc++

lint-fix:
	clang-format ./src/*.cc -i