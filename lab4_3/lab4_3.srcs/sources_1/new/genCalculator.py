def pad(ansStr):
    for i in range(0,3-len(ansStr)):
        ansStr = "X" + ansStr
    return ansStr

def encode(ans):
    encoded = ""
    for c in str(ans):
        if(c >= "0" and c <= "9"):
            encoded += "0" + c
        elif(c == "-"):
            encoded += "10"
        elif(c == "X"):
            encoded += "1F"
    return encoded

def genLine(a,b,opcode):
    if(opcode == 0): # add
        ans = a + b
    elif(opcode == 1): # sub
        ans = a - b
    elif(opcode == 2): # mul
        ans = a * b
    elif(opcode == 3): # div
        if(b == 0): ans = "-"
        else: ans = a // b
    with open("calculator.mem","a") as f:
        f.write(encode(pad(str(ans))) + "\n")

def gen(opcode):
    for a in range(0,16):
        for b in range(0,16):
            genLine(a,b,opcode)

def main():
    with open("calculator.mem","w") as f:
        f.write("")
    for i in range(0,4):
        gen(i)

if __name__ == "__main__":
    main()