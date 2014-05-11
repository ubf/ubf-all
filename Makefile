
REBAR?=./rebar

.PHONY: all clean deps compile xref doc test eunit eqc proper \
	compile-for-eunit compile-for-eqc compile-for-proper

all: compile

deps:
	$(REBAR) get-deps

clean:
	$(REBAR) clean -r

compile:
	$(REBAR) compile

xref:
	$(REBAR) xref -r

doc:
	@rm -rf README.md doc/edoc-info doc/*.md
	$(REBAR) -C rebar.config.doc get-deps compile
	$(REBAR) -C rebar.config.doc doc

test: eunit

eunit: compile-for-eunit
	$(REBAR) eunit -r

eqc: compile-for-eqc
	$(REBAR) eqc -r

proper: compile-for-proper
	@echo "rebar does not implement a 'proper' command" && false

compile-for-eunit:
	$(REBAR) compile eunit compile_only=true

compile-for-eqc:
	$(REBAR) -D QC -D QC_EQC compile eqc compile_only=true

compile-for-proper:
	$(REBAR) -D QC -D QC_PROPER compile eqc compile_only=true
