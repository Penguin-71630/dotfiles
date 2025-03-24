import sys, os
sys.path.append("/home/gino/scripts/")

import re
from pathlib import Path
from bs4 import BeautifulSoup
from terminal import system, coloredEcho, startSTEP, sysInit
from colorama import Fore, Style
sysInit()


CP_FOLDER = "/home/gino/code/competitive_programming"

def parseProblemsHTML(problemsHTML):
    with open(problemsHTML, "r", encoding="utf-8") as file:
        htmlContent = file.read()
    soup = BeautifulSoup(htmlContent, "lxml")

    ### GET CONTEST ID
    comments = soup.find_all(string=lambda text: isinstance(text, str) and "https://codeforces.com/" in text)
    URL = re.findall(r"https?://[^\s<>\"']+", comments[0])[0]
    URL = URL.split("/")
    contestType = URL[-3]
    contestID = URL[-2]
    print(f"Contest Website: CF\n"
          f"Contest Type: {'Official Contest' if contestType == 'contest' else 'Gym'}\n"
          f"Contest ID: {contestID}")

    coloredEcho("CYAN", "Wanna add a short title to contest? (Leave empty and hit ENTER if no)")
    contestDescription = re.sub(r"\s+", "-", input(f"{Fore.CYAN}>>> {Style.RESET_ALL}").strip()) 

    ### Contest Archive Initialization
    """
    CF-contest-2081   # rootDIR
    |_ A
       |_ A.cpp
       |_ testcases
          |_ 1.in
          |_ 1.ac
    |_ B
    |_ C

    """
    rootDIR = f"{CP_FOLDER}/CF-{contestType}-{contestID}-{contestDescription}"
    system(f"mkdir {rootDIR} 2> /dev/null")
    
    ### PARSING SAMPLE I/O
    sampleTests = soup.find_all(class_="sample-test")
    for (sampleTest, problemID) in zip(sampleTests, range(ord('A'), ord('A') + len(sampleTests))):
        system(f"mkdir -p {rootDIR}/{chr(problemID)}/testcases #2> /dev/null")
        system(f"touch {rootDIR}/{chr(problemID)}/{chr(problemID)}.cpp")
        if os.path.getsize(f"{rootDIR}/{chr(problemID)}/{chr(problemID)}.cpp") == 0:
            system(f"cp /home/gino/code/competitive_programming/algo_lib/template.cpp {rootDIR}/{chr(problemID)}/{chr(problemID)}.cpp")

        sampleInputs = sampleTest.find_all(class_="input")
        sampleOutputs = sampleTest.find_all(class_="output")

        for (sampleInput, cnt) in zip(sampleInputs, range(1, 1 + len(sampleInputs))):
            sampleInput = sampleInput.find("pre")
            if sampleInput:
                lines = [div.get_text(strip=True) for div in sampleInput.find_all("div")]
                if len(lines) == 0:
                    lines = [line.strip() for line in sampleInput.stripped_strings]
                coloredEcho("GREEN", f"[INFO] Sample Input {cnt} of problem {chr(problemID)}")
                with open(f"{rootDIR}/{chr(problemID)}/testcases/{cnt}.in", "w") as file:
                    file.write("\n".join(lines))
                print("\n".join(lines))

        for (sampleOutput, cnt) in zip(sampleOutputs, range(1, 1 + len(sampleOutputs))):
            sampleOutput = sampleOutput.find("pre")
            if sampleOutput:
                lines = [line.strip() for line in sampleOutput.stripped_strings]
                coloredEcho("GREEN", f"[INFO] Sample Output {cnt} of problem {chr(problemID)}")
                with open(f"{rootDIR}/{chr(problemID)}/testcases/{cnt}.ac", "w") as file:
                    file.write("\n".join(lines))
                print("\n".join(lines))

        coloredEcho("GRAY", "===============================")





coloredEcho("GRAY", "[INFO] Reading .html file of all problem statements...")
if len(sys.argv) == 1:
    coloredEcho("RED", "[ERROR] .html file not given, please specify a .html file you want to parse.")
    sys.exit(1)

for fileName in sys.argv[1:]:
    if (not Path(fileName).is_file()) or (not fileName.endswith(".html")):
        coloredEcho("YELLOW", f"[WARN] file {fileName} is not a valid html file, skipping...")
        continue
    parseProblemsHTML(fileName);

