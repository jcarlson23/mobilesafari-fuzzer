#include <notify.h>
#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>
#include <string.h>
#import <Foundation/Foundation.h>

static int seed = -1;

// XXX: Allow specifying an outputFile too?
static const char *inputFile;

static void fuzz()
{
	// Is 20000 a good number?
	int fuzzingSeed = (seed == -1 ? arc4random() % 20000 : seed);

	// (Don't forget to change this if we allow setting an outFile!)
	char *command = (char *)malloc(strlen(inputFile) + 60);
	if (!command) {
		fprintf(stderr, "Not enough RAM!");
		exit(EXIT_FAILURE);
	}

	sprintf(command, "zzuf -s%d -r0.005 < %s > /var/mobile/Media/Safari/out.mov", fuzzingSeed, inputFile);

	printf("Executing command: %s\n", command);
	system(command);
	free(command);

	sleep(2);
	notify_post("me.haunold.safarirefresh");
}

static void print_usage()
{
	printf("msafari_fuzzer 0.1 by Cykey (David Murray)\n"
		   "\t-i [--infile]: Path to the file to be fuzzed.\n"
		   "\t-s [--seed]: Specify a custom seed. If one is not specified, a random one will be generated each time.\n"
		   "\t-h [--help]: Print this help message.\n");

	exit(0);
}

int main(int argc, char **argv, char **envp)
{
	int c = 0;
	int optindex = 0;

	static struct option long_options[] = {
			{"infile", required_argument, 0, 'i'},
			{"seed",   required_argument, 0, 's'},
			{"help",   no_argument,       0, 'h'},
			{0, 0, 0, 0}
	};

	while ((c = getopt_long(argc, argv, "hi:s:", long_options, &optindex)) != -1) {
		switch (c) {
			case 'h': {
				print_usage();

				break;
			}

			case 's': {
				char *err = NULL;
				seed = strtol(optarg, &err	, 10);

				if (err) {
					printf("Couldn't convert this part of the string to a number: %s\n", err);
					break;
				}

				printf("Setting seed: %i\n", seed);

				break;
			}

			case 'i': {
				printf("Setting input file path: %s\n", optarg);
				inputFile = optarg;

				break;
			}

		}
	}

	if (!inputFile) {
		print_usage();
		return 0;
	}

	while (1) {
		printf("trying random stuff!\n");

		fuzz();
		sleep(7);
	}

	return 0;
}
