

from pathlib import Path
import subprocess
import sys
import tempfile
from clingo import Control, Number, SymbolType
from clingo.symbol import Function
from random import randint
from math import ceil


class GraphGenerator:
    def __init__(self, node,init_program):
        self.node = node
        self.init_program = init_program
        self.control = None
        self.correct_cnt = 0
        self.total_cnt = 0
        self.outputbk = open("bk.pl", "w")
        # self.outputbk.write(f"num_of_nodes({node}).\n") TODO
        self.outputexs = open("exs.pl", "w")
    def init_solver(self,number):
        self.control = Control(['-Wnone',"--rand-freq=0.9"])
        self.control.load((Path(__file__).parent / "generator.lp").__str__())
        self.control.add("base", [], f":- not num_of_nodes({number}).")
        self.control.configuration.solve.models = 0
        self.control.ground([("base", [])])
    def get_c_func(self, model):
        
        c_code = f"{self.node}* build_graph()" + "{\n"
        node_atom = list(filter(lambda x: x.name == "node", model.symbols(shown = True)))
        if len(node_atom) == 0:
            return f"{self.node}* build_graph()" + "{\nreturn NULL;\n}"
        start_atom = list(filter(lambda x: x.name == "start", model.symbols(shown = True)))


        assert len(start_atom) == 1
        for atom in node_atom:
            c_code += f"{self.node} * {atom.arguments[0]} = ({self.node} *) malloc(sizeof({self.node}));\n"
            c_code += f"memset({atom.arguments[0]}, 0, sizeof({self.node}));\n"
        for atom in model.symbols(shown = True):
            if atom.name == "relation":
                c_code += f"{atom.arguments[1]}->{atom.arguments[0]} = {atom.arguments[2]};\n"
        c_code += f"return {list(start_atom)[0].arguments[0]};\n}}"
        return c_code
    
    def test_on_program(self, graph_generator):
        with tempfile.NamedTemporaryFile(mode='w', suffix=".c") as f:
            f.write(graph_generator)
            f.flush()
            subprocess.run(["gcc", f.name, "-o", f.name[:-2]], check = True)
            output = subprocess.run([f.name[:-2]], stderr=subprocess.PIPE)
            outputstr = output.stderr.decode("utf-8")
            #delete the file
            subprocess.run(["rm", f.name[:-2]])
            if outputstr == '':
                return True
            else:
                return False
    def model_to_graph(self, model):
        prefix = "g"+str(self.correct_cnt)
        node_atom = list(filter(lambda x: x.name == "node", model.symbols(shown = True)))
        node_atom = list(map(lambda x: x.arguments[0].name, node_atom))
        start_atom = list(filter(lambda x: x.name == "start", model.symbols(shown = True)))
        start_atom = start_atom[0].arguments[0].name
        pts = list(filter(lambda x: x.name == "type", model.symbols(shown = True)))
        pts = list(map(lambda x: x.arguments[0].name, pts))
        fullpts = dict()
        for pt in pts:
            fullpts[pt] = node_atom
        if len(node_atom) == 0:
            return None
        valueset = []
        # graph = {}
        for atom in model.symbols(shown = True):
            if atom.name == "relation":
                # relation(name, node1, node2) into name(node1, node2)
                # relation(name, node1, non_node) into name(node1, non_node)
                fullpts[atom.arguments[0].name] = list(filter(lambda x: x != atom.arguments[1].name, fullpts[atom.arguments[0].name])) 
                if atom.arguments[2].type == SymbolType.Function:
                    self.outputbk.write(f"{atom.arguments[0].name}({prefix}_{atom.arguments[1].name},{prefix}_{atom.arguments[2].name}).\n")
                else:
                    # print(atom.arguments[2].type)
                    self.outputbk.write(f"{atom.arguments[0].name}({prefix}_{atom.arguments[1].name},{atom.arguments[2].number}).\n")
                    valueset.append(atom.arguments[2].number)
        for pt in fullpts:
            for node in fullpts[pt]:
                self.outputbk.write(f"{pt}({prefix}_{node}, null).\n")
        self.outputbk.write(f"\n")
        valueset = sorted(dict.fromkeys(valueset))
        self.outputexs.write(f"pos(p({prefix}_{start_atom},[{','.join(map(str,valueset))}])).\n")
    def generate_graph(self,number_of_nodes, count_to_generate):
        total_cnt = 0
        correct_cnt = 0
        print(f"Generating {count_to_generate} graphs with {number_of_nodes} nodes")
        with self.control.solve(yield_ = True,assumptions= [(Function("num_of_nodes",[Number(number_of_nodes)]),True)]) as handle:
            handle = iter(handle)
            while True:
                model = next(handle, None)
                if model == None:
                    return (total_cnt, correct_cnt)
                total_cnt += 1
                if total_cnt % 10 == 0:
                    print(f"Generated {total_cnt} graphs in the current configuration")
                test = self.test_on_program(self.init_program+self.get_c_func(model))
                if test:
                    # print(model.symbols(shown = True))
                    self.model_to_graph(model)
                    correct_cnt += 1
                    self.correct_cnt += 1
                    print(f"Correct:{self.correct_cnt}")
                    if correct_cnt == count_to_generate:
                        return (total_cnt, correct_cnt)
              
    def loop(self,to_generate):
        for i in range(1,6):
            self.init_solver(i)
            out=gg.generate_graph(i, ceil((to_generate-self.correct_cnt)/(6-i)))
            self.total_cnt += out[0]
            print(f"Total number of graphs generated: {self.total_cnt}")
            print(f"Correct number of graphs generated: {self.correct_cnt}")

if __name__ == "__main__":
    # command line arguments
    args = sys.argv
    assert len(args) == 2 or len(args) == 3
    to_generate = 100
    path = Path.cwd() / args[1]
    if len(args) == 3:
        to_generate = int(args[2])
    init_program = path.read_text()

    node = "BNode"
    gg = GraphGenerator(node,init_program)

    gg.loop(to_generate)

    print(f"Total number of graphs generated: {gg.total_cnt}")