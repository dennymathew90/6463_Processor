
# I am just printing out the machine codes...copy paste from console! :P
# you can also copy paste from out.txt file which will be created in the same directory!
# I know I followed a bad programming style....I was in a hurry!! Sorry.

import math

f = open("round_key.txt") # provide the text file...
out = open("out.txt",'w')
lines = f.readlines()

# Defining Instruction type.
I_INS = ["ADDI","SUBI","ANDI","ORI","SHL","SHR","LW","SW","BLT","BEQ","BNE"]
R_INS = ["ADD","SUB","AND","OR","NOR"]
J_INS = ["JMP","HAL"]

x=1
for i in lines:
    line = i.strip().split(" ")
    
    # Processing I type Instructions
    if(line[0].upper() in I_INS):
        
        #rs = format(int(line[1].upper().replace("R","").replace(",","")), 'b').zfill(5)
        #rt = format(int(line[2].upper().replace("R","").replace(",","")), 'b').zfill(5)
        
        
        if(line[0].upper() !="SW" and line[0].upper() != "LW" and int(line[3].upper().replace("R",""))<0):
            imm = bin(int(line[3]) & 0b1111111111111111)[2:]
            rs = format(int(line[1].upper().replace("R","").replace(",","")), 'b').zfill(5)
            rt = format(int(line[2].upper().replace("R","").replace(",","")), 'b').zfill(5)
        
        if(line[0].upper() !="SW" and line[0].upper() != "LW" and int(line[3].upper().replace("R",""))>=0):
            imm = bin(int(line[3]))[2:].zfill(16)
            rs = format(int(line[1].upper().replace("R","").replace(",","")), 'b').zfill(5)
            rt = format(int(line[2].upper().replace("R","").replace(",","")), 'b').zfill(5)
        
        if(line[0].upper()=="SW" and int(line[2].split("(")[0])>=0):
            imm = format(int(line[2].split("(")[0]),'b').zfill(16)
            #print(imm)
            rs = format(int(line[1].upper().replace("R","").replace(",","")), 'b').zfill(5)
            rt = format(int(line[2].split("(")[1].upper().replace("R","").replace(")","")), 'b').zfill(5)
        
        if(line[0].upper() =="LW" and int(line[2].split("(")[0])>=0):
            imm = format(int(line[2].split("(")[0]),'b').zfill(16)
            #print(imm)
            rs = format(int(line[1].upper().replace("R","").replace(",","")), 'b').zfill(5)
            rt = format(int(line[2].split("(")[1].upper().replace("R","").replace(")","")), 'b').zfill(5)


        if(line[0].upper() =="SW" and int(line[2].split("(")[0])<0):
            #imm_tmp = format(int(line[2].replace("R","").replace(",","")),'b')
            imm = bin(int(line[2].split("(")[0]) & 0b1111111111111111)[2:]
            rs = format(int(line[1].upper().replace("R","").replace(",","")), 'b').zfill(5)
            rt = format(int(line[2].split("(")[1].upper().replace("R","").replace(")","")), 'b').zfill(5)
        
        if(line[0].upper() =="LW" and int(line[2].split("(")[0])<0):
            #imm_tmp = format(int(line[2].replace("R","").replace(",","")),'b')
            imm = bin(int(line[2].split("(")[0]) & 0b1111111111111111)[2:]
            rs = format(int(line[1].upper().replace("R","").replace(",","")), 'b').zfill(5)
            rt = format(int(line[2].split("(")[1].upper().replace("R","").replace(")","")), 'b').zfill(5)


        
        if(line[0].upper()=="ADDI"):
            opcode = "000001"
            inst = opcode+rt+rs+imm
        if(line[0].upper()=="SUBI"):
            opcode = "000010"
            inst = opcode+rt+rs+imm
        if(line[0].upper()=="ANDI"):
            opcode = "000011"
            inst = opcode+rt+rs+imm
        if(line[0].upper()=="ORI"):
            opcode = "000100"
            inst = opcode+rt+rs+imm
        if(line[0].upper()=="SHL"):
            opcode = "000101"
            inst = opcode+rt+rs+imm
        if(line[0].upper()=="SHR"):
            opcode = "000110"
            inst = opcode+rt+rs+imm
        if(line[0].upper()=="LW"):
            opcode = "000111"
            inst = opcode+rt+rs+imm
        if(line[0].upper()=="SW"):
            opcode = "001000"
            inst = opcode+rt+rs+imm
        if(line[0].upper()=="BLT"):
            opcode = "001001"
            inst = opcode+rt+rs+imm
        if(line[0].upper()=="BEQ"):
            opcode = "001010"
            inst = opcode+rt+rs+imm
        if(line[0].upper()=="BNE"):
            opcode = "001011"
            inst = opcode+rt+rs+imm
        inst = "ram("+str(x)+") <= \""+inst+"\";"
        print(inst)
        out.write(inst+'\n')
    
    # Processing R type instructions
    
    if(line[0].upper() in R_INS):
        #print(line[3])
        opcode = "000000"
        rs = format(int(line[1].upper().replace("R","").replace(",","")), 'b').zfill(5)
        rt = format(int(line[2].upper().replace("R","").replace(",","")), 'b').zfill(5)
        rd = format(int(line[3].upper().replace("R","").replace(",","")), 'b').zfill(5)
        shmt = "00000"
        
        
        if(line[0].upper()=="ADD"):
            fun_hex = "010000"
            inst = opcode+rd+rt+rs+shmt+fun_hex
        if(line[0].upper()=="SUB"):
            fun_hex = "010001"
            inst = opcode+rd+rt+rs+shmt+fun_hex
        if(line[0].upper()=="AND"):
            fun_hex = "010010"
            inst = opcode+rd+rt+rs+shmt+fun_hex
        if(line[0].upper()=="OR"):
            fun_hex = "010011"
            inst = opcode+rd+rt+rs+shmt+fun_hex
        if(line[0].upper()=="NOR"):
            fun_hex = "010100"
            inst = opcode+rd+rt+rs+shmt+fun_hex
        inst = "ram("+str(x)+") <= \""+inst+"\";"
        print(inst)    
        out.write(inst+'\n')
    
    # Processing J-type instructions..
    
    if(line[0].upper() in J_INS):
        
        if(line[0] == "HAL"):
            opcode = "111111"
            inst = opcode+"00000000000000000000000000"
        else:
            opcode = "001100"
            addr = format(int(line[1]), 'b').zfill(26)
        inst = "ram("+str(x)+") <= \""+inst+"\";"
        print(inst)
        out.write(inst+'\n')

    x+=1
        
        
        
        




