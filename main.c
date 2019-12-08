#include <ftw.h>
#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>

/**
 * @brief Callback for every entry visited. The approriate leading spaces are added
 * and the basename is then printed stdout.
 */
int callback(const char* path, const struct stat64* stat, int type, struct FTW* ftw);

/**
 * @brief main entry point
 */
void main(int argc, char* argv);

int callback(const char* path, const struct stat64* stat, int type, struct FTW* ftw) {
	// Print a number of spaces equal to 2 * the indent level and only
	// print the base name.
	printf("%*s%s\n", ftw->level * 2, "", (path + ftw->base));
	return 0;
}

void main(int argc, char* argv) {
	nftw64(".", *callback, 1, 0);
}
