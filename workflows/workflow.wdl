version 1.0
#WORKFLOW DEFINITION

# Meant to be used as integration test, comparing contents of input file and output file
workflow TestFlow {
	input {
		File input_txt_file
	}


	call TxtFileCopyTask{
		input:
			input_txt_file = input_txt_file,
	}

	output {
		File output_txt_file = TxtFileCopyTask.output_txt_file
	}

}

#Task Definitions
task TxtFileCopyTask {
	input {
		File input_txt_file
	}

	command {
		cat ~{input_txt_file} > outfile.txt
	}

	output {
		File output_txt_file = "outfile.txt"
	}
}