OCAMLC = ocamlc

#Roots:
R_Test = Tests
R_HW1 = hw1
R_HW2 = hw1_reduction
R_HW3 = hw2_unify
R_HW4 = hw2_inference

#Sourses
HW1_SRC = $(R_HW1)/hw1.mli $(R_HW1)/hw1.ml
HW2_SRC = $(R_HW2)/hw1_reduction.mli $(R_HW2)/hw1_reduction.ml
HW3_SRC = $(R_HW3)/hw2_unify.mli $(R_HW3)/hw2_unify.ml
HW4_SRC = $(R_HW4)/hw2_inference.mli $(R_HW4)/hw2_inference.ml

#Test names:
HW1_TEST_NAME = test_hw1
HW2_TEST_NAME = test_hw1_reduction
HW3_TEST_NAME = test_hw2_unify
HW4_TEST_NAME = test_hw2_inference

all: compile_hw1 compile_hw1_reduction compile_hw2_unify compile_hw2_inference

compile_hw1: $(HW1_SRC)
	$(OCAMLC) -c -I $(R_HW1) $(HW1_SRC)

test_hw1: $(HW1_SRC) $(R_Test)/$(HW1_TEST_NAME).ml
	$(OCAMLC) -I $(R_HW1) $(HW1_SRC)\
	          -I $(R_Test) $(R_Test)/$(HW1_TEST_NAME).ml -o $(HW1_TEST_NAME).tmp

compile_hw1_reduction: compile_hw1
	$(OCAMLC) -c -I $(R_HW1)/ $(R_HW1)/hw1.cmo \
			  -I $(R_HW2)/ $(HW2_SRC)

test_hw1_reduction: compile_hw1 $(HW2_SRC) $(R_Test)/$(HW2_TEST_NAME).ml
	$(OCAMLC) -I $(R_HW1)/ $(R_HW1)/hw1.cmo \
			  -I $(R_HW2)/ $(HW2_SRC) \
	          -I $(R_Test)/ $(R_Test)/$(HW2_TEST_NAME).ml -o $(HW2_TEST_NAME).tmp

compile_hw2_unify: $(HW3_SRC)
	$(OCAMLC) -c -I $(R_HW3)/  $(HW3_SRC)

test_hw2_unify: $(HW3_SRC) $(R_Test)/$(HW3_TEST_NAME).ml
	$(OCAMLC) -I $(R_HW3)/  $(HW3_SRC) \
	          -I $(R_Test)/ $(R_Test)/$(HW3_TEST_NAME).ml -o $(HW3_TEST_NAME).tmp

compile_hw2_inference: compile_hw1 compile_hw1_reduction compile_hw2_unify
	$(OCAMLC) -c -I $(R_HW1)/ $(R_HW1)/hw1.cmo \
	          -I $(R_HW2)/ $(R_HW2)/hw1_reduction.cmo\
	          -I $(R_HW3)/ $(R_HW3)/hw2_unify.cmo \
	          -I $(R_HW4)/ $(HW4_SRC) 

test_hw2_inference: compile_hw1 compile_hw1_reduction compile_hw2_unify
	$(OCAMLC) -I $(R_HW1)/ $(R_HW1)/hw1.cmo \
	          -I $(R_HW2)/ $(R_HW2)/hw1_reduction.cmo\
	          -I $(R_HW3)/ $(R_HW3)/hw2_unify.cmo \
	          -I $(R_HW4)/ $(HW4_SRC) \
	          -I $(R_Test)/ $(R_Test)/$(HW3_TEST_NAME).ml -o $(HW4_TEST_NAME).tmp

clean:
	rm -f -r *.cmi *.cmo *.tmp