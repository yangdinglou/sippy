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
from clingo import Control, Function, Number, String
from random import randint

domains = ["key","next"]
node = "SNnode"

class GraphGenerator:
    def __init__(self, domains, node):
        self.domains = domains
        self.node = node
        self.control = Control(['-Wnone',"-t8"])
        self.control.load((Path(__file__).parent / "lists.lp").__str__())
        self.control.configuration.solve.models = 0
        self.random_const(10)
        # self.control.ground([("base", [])])
    def random_const(self, number):
        for i in range(number):
            self.control.add("base", [], f"const({randint(0, 20)}).")
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
        for atom in model.symbols(shown = True):
            if atom.name == "value":
                if "value" not in self.domains and "key" in self.domains:
                    c_code += f"{atom.arguments[0]}->key = {atom.arguments[1]};\n"
                else:
                    c_code += f"{atom.arguments[0]}->value = {atom.arguments[1]};\n"
            elif atom.name == "next":
                c_code += f"{atom.arguments[0]}->next = {atom.arguments[1]};\n"
            elif atom.name == "prev":
                c_code += f"{atom.arguments[0]}->prev = {atom.arguments[1]};\n"
            elif atom.name == "nullnext":
                c_code += f"{atom.arguments[0]}->next = NULL;\n"
            elif atom.name == "left":
                c_code += f"{atom.arguments[0]}->left = {atom.arguments[1]};\n"
            elif atom.name == "right":
                c_code += f"{atom.arguments[0]}->right = {atom.arguments[1]};\n"
            elif atom.name == "nullleft":
                c_code += f"{atom.arguments[0]}->left = NULL;\n"
            elif atom.name == "nullright":
                c_code += f"{atom.arguments[0]}->right = NULL;\n"
        c_code += f"return {list(start_atom)[0].arguments[0]};\n}}"
        return c_code
    def generate_graph(self):
        self.control.ground([("base", [])])
        with self.control.solve(yield_ = True) as handle:
            handle = iter(handle)
            for i in range(10):
                model = next(handle, None)
                if model == None:
                    break
                print(self.get_c_func(model))

if __name__ == "__main__":
    domains = ["key","next"]
    node = "SNnode"
    gg = GraphGenerator(domains,node)
    gg.generate_graph()