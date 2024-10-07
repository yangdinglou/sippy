# Sippy

This repository contains the code for the paper "Inductive Synthesis of Inductive Heap Predicates", where three different components are presented:

1. **Sippy**: the tool for synthesizing inductive heap predicates from examples, based on open-source tool [Popper](https://github.com/logic-and-learning-lab/Popper), whose benchmark is in the folder `./predicates/experiments`, and implemented in the folder `./popper`.
2. **Grippy-benchmark**: the tool and benchmark to generate input graphs for Sippy using Grippy, shown in the folder `./graphgen_experiments`.
3. **SuSLik-benchmark**: the benchmark that uses output of Sippy to synthesize heap-manipulating programs by SuSLik, shown in the folder `./suslik_experiments`.


### Requirements

- [pyswip](https://github.com/yuce/pyswip) (You **_must_** install pyswip from the master branch! with  the command: `pip install git+https://github.com/yuce/pyswip@master#egg=pyswip`)
- [SWI-Prolog](https://www.swi-prolog.org) (8.4.2 or above)
- [Clingo](https://potassco.org/clingo/) (5.5.0 or above)
- [SuSLik](https://github.com/TyGuS/suslik/) (to run the SuSLik benchmarks)


## Instructions

### Sippy

To run Sippy, you can use the following command:

```bash
./sippy.sh <path-to-examples>
```

For example, to run the benchmark for the `sll` predicate, you can use the following command:

```bash
./sippy.sh ./predicates/experiments/sll
```

The detailed execution logs will be saved in `./example.log`.

To compare with Popper, and with or without the use of optimisations, you can use the following commands:

```bash
./sippy.sh ./predicates/experiments/sll --unopt
./popper.sh ./predicates/experiments/sll 
./popper.sh ./predicates/experiments/sll --unopt
```

### Grippy-benchmark

As an example to generate input graphs for sorted list by find functions, you can use the following commands:

```bash
cd VCDryad_experiments/graph_generation/c-programs/srtl
python3 c-graphs-generator.py srtl-find.c
```
or the following with timeout:
```bash
timeout 10m python3 c-graphs-generator.py srtl-find.c 
```

For output the VCDryad predicates, you can use the following command:

```bash
./sippy.sh ./VCDryad_experiments/output_predicates/sorted
```

### SuSLik-benchmark

To run the SuSLik benchmarks, you can use the following command:

(Assume suslik is added to the path)

```bash
suslik ./suslik_experiments/copy/dll.syn
```
