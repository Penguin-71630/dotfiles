#!/usr/bin/env fish

# 預設 base directory
set BASE_DIR "$HOME/code/competitive_programming"

# 預設 HTML 檔案路徑
set DEFAULT_HTML_FILE "$BASE_DIR/Problems - Codeforces.html"

# cfparse 解析指令
function cf_parse
    set html_file $argv[1]
    if test -z "$html_file"
        set html_file $DEFAULT_HTML_FILE
    end
    echo "[INFO] Parsing HTML file: $html_file"
    cfparse $html_file
end

# cf goto 指令
function cf_goto
    set contest_id $argv[1]
    set problem_id (string upper $argv[2])

    set contest_dir (find $BASE_DIR -maxdepth 1 -type d -iname "*$contest_id*")

    # 如果沒有指定 contestID 和 problemID
    if test -z "$contest_id" -a -z "$problem_id"
        echo "[INFO] No contestID or problemID specified. Changing to base directory."
        cd $BASE_DIR
    else if test -n "$contest_id" -a -z "$problem_id"
        echo "[INFO] Changing to contest directory: $contest_dir"
        cd "$contest_dir"
    else if test -n "$contest_id" -a -n "$problem_id"
        echo "[INFO] Changing to problem directory: $contest_dir/$problem_id"
        cd "$contest_dir/$problem_id"
    else
        echo "[ERROR] Invalid arguments for cf goto."
        exit 1
    end
end

# cf run 指令
function cf_run
    set code_file $argv[1]
    if test -z "$code_file"
        # 如果沒有指定檔案，找當前目錄唯一的 .cpp 檔案
        set code_file (ls *.cpp | head -n 1)
        if test -z "$code_file"
            echo "[ERROR] No .cpp file found in the current directory."
            exit 1
        end
    end

    echo "[INFO] Running sample tests on $code_file"
    # 執行 runtest 腳本
    runtest $code_file
end

# 顯示 usage 信息
function usage
    echo "Usage: cf {parse|goto|run|rebase} [arguments]"
    echo ""
    echo "Commands:"
    echo "  parse [HTML file]        Parse the given HTML file (default: $DEFAULT_HTML_FILE)"
    echo "  goto [contestID] [problemID]    Change to the specified directory:"
    echo "                              - 'cf goto' changes to base directory"
    echo "                              - 'cf goto contestID' changes to contest directory"
    echo "                              - 'cf goto contestID problemID' changes to problem directory"
    echo "  run [codeFile.cpp]       Run test on the given C++ file."
    echo "                              - 'cf run' runs the .cpp file in the current directory"
    echo "                              - 'cf run codeFile.cpp' runs the specified C++ file"
    echo "  rebase [DIR]             Change the base directory to [DIR]."
    echo "                              - 'cf rebase DIR' changes the base directory"
    echo ""
    echo "Options:"
    echo "  --help                   Show this help message"
end

# 檢查參數，如果是 --help 顯示 usage
if test "$argv[1]" = "--help"
    usage
    exit 0
end

# 判斷使用的指令
switch "$argv[1]"
    case "parse"
        cf_parse $argv[2]

    case "goto"
        cf_goto $argv[2] $argv[3]

    case "run"
        cf_run $argv[2]

    case "rebase"
        cf_rebase $argv[2]

    case else
        echo "[ERROR] Invalid command. Use 'cf --help' for usage."
        exit 1
end
