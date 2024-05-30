# I'm going to call Clingo to generate memory graphs in the format of 
# node(n00) node(n01) node(n02) node(n03) node(n04) right(n02,n03) left(n00,n01) left(n01,n02) left(n03,n04) nullright(n00) nullright(n01) nullright(n03) nullright(n04) nullleft(n02) nullleft(n04) start(n00) value(n00,1) value(n01,3) value(n02,2) value(n03,3) value(n04,2)
# Then after getting the models from Clingo, I'm going to convert them to a C graph by a function like the following:

# BNode * n00 = (BNode *) malloc(sizeof(BNode));
# BNode * n01 = (BNode *) malloc(sizeof(BNode));
# BNode * n02 = (BNode *) malloc(sizeof(BNode));
# BNode * n03 = (BNode *) malloc(sizeof(BNode));
# BNode * n04 = (BNode *) malloc(sizeof(BNode));

# n00->value = 1;
# n01->value = 3;
# n02->value = 2;
# n03->value = 3;
# n04->value = 2;

# n00->left = n01;
# n00->right = NULL;
# n01->left = n02;
# n01->right = NULL;
# n02->left = NULL;
# n02->right = n03;
# n03->left = n04;
# n03->right = NULL;
# n04->left = NULL;
# n04->right = NULL;



from pathlib import Path
import subprocess
import sys
import tempfile
from clingo import Control, Function, Number, String
from random import randint


class GraphGenerator:
    def __init__(self,  node):
        self.node = node
        self.control = Control(['-Wnone',"-t8"])
        self.control.load((Path(__file__).parent / "generator.lp").__str__())
        self.control.configuration.solve.models = 0
        self.control.ground([("base", [])])
    def get_c_func(self, model):
        print(model.symbols(shown = True))
        
        c_code = f"{self.node}* build_graph()" + "{\n"
        node_atom = list(filter(lambda x: x.name == "node", model.symbols(shown = True)))
        if len(node_atom) == 0:
            return f"{self.node}* build_graph()" + "{\nreturn NULL;\n}"
        start_atom = list(filter(lambda x: x.name == "start", model.symbols(shown = True)))
        for atom in start_atom:
            print(atom)

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
            print(f.name)
            subprocess.run(["gcc", f.name, "-o", f.name[:-2]], check = True)
            output = subprocess.run([f.name[:-2]], stdout=subprocess.PIPE)
            outputstr = output.stdout.decode("utf-8")
    def generate_graph(self,number_of_nodes, count_to_generate):
        total_cnt = 0
        correct_cnt = 0
        with self.control.solve(yield_ = True,assumptions= [(Function("num_of_nodes",[Number(number_of_nodes)]),True)]) as handle:
            handle = iter(handle)
            model = next(handle, None)
            if model == None:
                return (total_cnt, correct_cnt)
            print(self.get_c_func(model))

if __name__ == "__main__":
    # command line arguments
    args = sys.argv
    assert len(args) == 2
    path = Path.cwd() / args[1]
    program = path.read_text()
    print(program)

    node = "SNnode"
    gg = GraphGenerator(node)
    for i in range(1000):
        gg.generate_graph()