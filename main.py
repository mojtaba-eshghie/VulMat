import os
import json
import solcx
import solcast
import re
import pandas as pd


MAPPING = {
    'reentrancy': {
        "slither": [
            "reentrancy-benign",
            "reentrancy-events",
            "reentrancy-no-eth",
            "reentrancy-unlimited-gas",
            "reentrancy-eth",
        ],
        'semgrep': [
            "compound-borrowfresh-reentrancy",
            "erc721-reentrancy",
            "curve-readonly-reentrancy",
            "erc777-reentrancy",
            "erc677-reentrancy"
        ],
        'smartcheck': [

        ]
    },
    'low-level-calls': {
        'slither': [],
        'semgrep': [
            'arbitrary-low-level-call'
        ],
        'smartcheck': [
            'SOLIDITY_CALL_WITHOUT_DATA'
        ]
    },
    'access-control': {
        'slither': [
            "arbitrary-send-erc20",
            "arbitrary-send-eth",
            "suicidal",
            "arbitrary-send-erc20-permit",
        ],
        'semgrep': [
            'compound-sweeptoken-not-restricted',
            'erc20-public-burn',
            'accessible-selfdestruct',
            'oracle-price-update-not-restricted',
            'uniswap-callback-not-protected',

        ],
        'smartcheck': [
            'SOLIDITY_TX_ORIGIN'
        ]
    },
    'delegation': {
        'slither': [
            "controlled-delegatecall",
            "delegatecall-loop",
        ],
        'semgrep': [
            'delegatecall-to-arbitrary-address',

        ],
        'smartcheck': [

        ]
    },
    'arithmetic': {
        'slither': [
            "divide-before-multiply",
        ],
        'semgrep': [
            'basic-arithmetic-underflow'
        ],
        'smartcheck': [
            'SOLIDITY_DIV_MUL'
        ]
    },
    'oracle-manipulation': {
        'slither': [],
        'semgrep': [
            'keeper-network-oracle-manipulation'
        ],
        'smartcheck': [

        ]
    },
    'input-validation': {
        'slither': [
            "missing-zero-check",
        ],
        'semgrep': [

        ],
        'smartcheck': [

        ]
    },
    'shadowing': {
        'slither': [
            "shadowing-local",
            "shadowing-state",
            "shadowing-abstract",
        ],
        'semgrep': [

        ],
        'smartcheck': [

        ]
    },
    'compliance': {
        'slither': [
            "erc20-interface",
        ],
        'semgrep': [

        ],
        'smartcheck': [
            'SOLIDITY_ERC20_TRANSFER_SHOULD_THROW'
        ]
    },
    'timestamp': {
        "slither": [
            "timestamp",
            "weak-prng",
        ],
        'semgrep': [

        ],
        'smartcheck': [
        ]
    },
    'initialization': {
        'slither': [
            "uninitialized-local",
            "uninitialized-state",
        ],
        'semgrep': [

        ],
        'smartcheck': [

        ]
    },
    'poor-logic-flaws': {
        "slither": [
            "incorrect-equality",
            "boolean-cst",
        ],
        'semgrep': [
            'incorrect-use-of-blockhash'
        ],
        'smartcheck': [
            'SOLIDITY_EXACT_TIME',
            'SOLIDITY_BALANCE_EQUALITY'
        ]
    },
    'denial-of-service': {
        "slither": [
            "locked-ether",
            "calls-loop",
            "msg-value-loop",
        ],
        'semgrep': [

        ],
        'smartcheck': [
            'SOLIDITY_LOCKED_MONEY',
            'SOLIDITY_TRANSFER_IN_LOOP'
        ]
    },
    'state-corruption': {
        "slither": [
            "controlled-array-length",
        ],
        'semgrep': [

        ],
        'smartcheck': [
            'SOLIDITY_ARRAY_LENGTH_MANIPULATION'
        ]
    },
    'function-behavior': {
        "slither": [
            'incorrect-modifier'
        ],
        'semgrep': [

        ],
        'smartcheck': [

        ]
    },
    'external-call-validation': {
        "slither": [
            "unchecked-transfer",
            "unchecked-lowlevel"
        ],
        'semgrep': [

        ],
        'smartcheck': [

        ]
    },
    'front-running': {
        "slither": [],
        'semgrep': [

        ],
        'smartcheck': [
            'SOLIDITY_ERC20_APPROVE'
        ]
    }
}

REVERSE_MAPPING = {
    'reentrancy-benign': {'category': 'reentrancy', 'analyzer': 'slither'},
    'reentrancy-events': {'category': 'reentrancy', 'analyzer': 'slither'},
    'reentrancy-no-eth': {'category': 'reentrancy', 'analyzer': 'slither'},
    'reentrancy-unlimited-gas': {'category': 'reentrancy', 'analyzer': 'slither'},
    'reentrancy-eth': {'category': 'reentrancy', 'analyzer': 'slither'},
    'compound-borrowfresh-reentrancy': {'category': 'reentrancy', 'analyzer': 'semgrep'},
    'erc721-reentrancy': {'category': 'reentrancy', 'analyzer': 'semgrep'},
    'curve-readonly-reentrancy': {'category': 'reentrancy', 'analyzer': 'semgrep'},
    'erc777-reentrancy': {'category': 'reentrancy', 'analyzer': 'semgrep'},
    'erc677-reentrancy': {'category': 'reentrancy', 'analyzer': 'semgrep'},
    'arbitrary-low-level-call': {'category': 'low-level-calls', 'analyzer': 'semgrep'},
    'SOLIDITY_CALL_WITHOUT_DATA': {'category': 'low-level-calls', 'analyzer': 'smartcheck'},
    'arbitrary-send-erc20': {'category': 'access-control', 'analyzer': 'slither'},
    'arbitrary-send-eth': {'category': 'access-control', 'analyzer': 'slither'},
    'suicidal': {'category': 'access-control', 'analyzer': 'slither'},
    'arbitrary-send-erc20-permit': {'category': 'access-control', 'analyzer': 'slither'},
    'compound-sweeptoken-not-restricted': {'category': 'access-control', 'analyzer': 'semgrep'},
    'erc20-public-burn': {'category': 'access-control', 'analyzer': 'semgrep'},
    'accessible-selfdestruct': {'category': 'access-control', 'analyzer': 'semgrep'},
    'oracle-price-update-not-restricted': {'category': 'access-control', 'analyzer': 'semgrep'},
    'uniswap-callback-not-protected': {'category': 'access-control', 'analyzer': 'semgrep'},
    'SOLIDITY_TX_ORIGIN': {'category': 'access-control', 'analyzer': 'smartcheck'},
    'controlled-delegatecall': {'category': 'delegation', 'analyzer': 'slither'},
    'delegatecall-loop': {'category': 'delegation', 'analyzer': 'slither'},
    'delegatecall-to-arbitrary-address': {'category': 'delegation', 'analyzer': 'semgrep'},
    'divide-before-multiply': {'category': 'arithmetic', 'analyzer': 'slither'},
    'basic-arithmetic-underflow': {'category': 'arithmetic', 'analyzer': 'semgrep'},
    'SOLIDITY_DIV_MUL': {'category': 'arithmetic', 'analyzer': 'smartcheck'},
    'keeper-network-oracle-manipulation': {'category': 'oracle-manipulation', 'analyzer': 'semgrep'},
    'missing-zero-check': {'category': 'input-validation', 'analyzer': 'slither'},
    'shadowing-local': {'category': 'shadowing', 'analyzer': 'slither'},
    'shadowing-state': {'category': 'shadowing', 'analyzer': 'slither'},
    'shadowing-abstract': {'category': 'shadowing', 'analyzer': 'slither'},
    'erc20-interface': {'category': 'compliance', 'analyzer': 'slither'},
    'SOLIDITY_ERC20_TRANSFER_SHOULD_THROW': {'category': 'compliance', 'analyzer': 'smartcheck'},
    'timestamp': {'category': 'timestamp', 'analyzer': 'slither'},
    'weak-prng': {'category': 'timestamp', 'analyzer': 'slither'},
    'uninitialized-local': {'category': 'initialization', 'analyzer': 'slither'},
    'uninitialized-state': {'category': 'initialization', 'analyzer': 'slither'},
    'incorrect-equality': {'category': 'poor-logic-flaws', 'analyzer': 'slither'},
    'boolean-cst': {'category': 'poor-logic-flaws', 'analyzer': 'slither'},
    'incorrect-use-of-blockhash': {'category': 'poor-logic-flaws', 'analyzer': 'semgrep'},
    'SOLIDITY_EXACT_TIME': {'category': 'poor-logic-flaws', 'analyzer': 'smartcheck'},
    'SOLIDITY_BALANCE_EQUALITY': {'category': 'poor-logic-flaws', 'analyzer': 'smartcheck'},
    'locked-ether': {'category': 'denial-of-service', 'analyzer': 'slither'},
    'calls-loop': {'category': 'denial-of-service', 'analyzer': 'slither'},
    'msg-value-loop': {'category': 'denial-of-service', 'analyzer': 'slither'},
    'SOLIDITY_LOCKED_MONEY': {'category': 'denial-of-service', 'analyzer': 'smartcheck'},
    'SOLIDITY_TRANSFER_IN_LOOP': {'category': 'denial-of-service', 'analyzer': 'smartcheck'},
    'controlled-array-length': {'category': 'state-corruption', 'analyzer': 'slither'},
    'SOLIDITY_ARRAY_LENGTH_MANIPULATION': {'category': 'state-corruption', 'analyzer': 'smartcheck'},
    'incorrect-modifier': {'category': 'function-behavior', 'analyzer': 'slither'},
    'unchecked-transfer': {'category': 'external-call-validation', 'analyzer': 'slither'},
    'unchecked-lowlevel': {'category': 'external-call-validation', 'analyzer': 'slither'},
    'SOLIDITY_ERC20_APPROVE': {'category': 'front-running', 'analyzer': 'smartcheck'}
}

statistics_matrices = {
    category: pd.DataFrame(
        index=pd.Index(detectors, name="detector"),
        columns=detectors,
        data=0
    )
    for category, analyzers in MAPPING.items()
    for detectors in [[detector for analyzer_detectors in analyzers.values() for detector in analyzer_detectors]]
}


def get_solidity_compiler_version(solidity_code):
    # Regular expression pattern to capture only the version number part
    pattern = r"pragma\s+solidity\s+[^\d]*(\d+\.\d+\.\d+);"

    # Search for the pattern in the solidity code
    match = re.search(pattern, solidity_code)

    # If a match is found, return the version number part of the match
    if match:
        return match.group(1)  # Returns the matched version number
    else:
        return "No pragma solidity statement found."


def compile_solidity_contract(file_path):
    source_code = open(file_path, 'r').read()

    pragma_version = get_solidity_compiler_version(source_code)

    solcx.install_solc(pragma_version)
    # solcx.use_solc(pragma_version)

    # Prepare input JSON for compilation with AST output
    input_json = {
        'language': 'Solidity',
        'sources': {file_path: {'content': source_code}},
        'settings': {
            'outputSelection': {
                '*': {
                    '*': ['metadata', 'evm.bytecode', 'evm.bytecode.sourceMap', 'abi'],
                    '': ['ast']  # Requesting AST output here
                }
            }
        }
    }

    # Compile and return output JSON
    output_json = solcx.compile_standard(
        input_json, allow_paths=".", solc_version=pragma_version)
    return output_json


def print_contract_ast(compiled_sol):
    nodes = solcast.from_standard_output(compiled_sol)
    for node in nodes:
        print(node)
        # Example to explore further: print the names of contracts in a SourceUnit
        for child in node['nodes']:
            if child['nodeType'] == 'ContractDefinition':
                print(f"Contract Name: {child['name']}")


def get_enclosing_function_and_contract(output_json, solidity_filename, start_line, end_line):

    function = None
    contract = None

    source_code = open(solidity_filename, 'r').read()

    nodes = solcast.from_standard_output(output_json)
    root_node = solcast.from_ast(
        output_json["sources"][solidity_filename]["ast"])

    # source_code_lines = source_code.split('\n')
    # start_index = 0
    # for i in range(0, start_line):
    #     if i < start_line - 1:
    #         start_index += len(source_code_lines[i])
    #     else:
    #         start_index += len(source_code_lines[i]) - \
    #             len(source_code_lines[i].lstrip(' '))

    # end_index = start_index
    # for j in range(start_line-1, end_line):
    #     end_index += len(source_code_lines[j])

    lines = source_code.split("\n")
    start_index = sum(len(lines[i]) + 1 for i in range(start_line - 1))
    start_index_adjusted = start_index + \
        len(lines[start_line - 1]) - len(lines[start_line - 1].lstrip())
    end_index = start_index + \
        sum(len(lines[i]) + 1 for i in range(start_line - 1, end_line)) - 1

    result = root_node.children(
        required_offset=(start_index_adjusted, end_index))

    for node in result:
        if node.nodeType == 'ContractDefinition':
            contract = {
                "offset": node.offset,
                "name": node.name
            }
        elif node.nodeType == 'FunctionDefinition':
            function = {
                "offset": node.offset,
                "name": node.name
            }

    return {
        "contract": contract,
        "function": function
    }


def count_json_files_recursively(start_path='.'):
    json_file_count = 0
    for root, dirs, files in os.walk(start_path):
        for file in files:
            if file.endswith('.json'):
                json_file_count += 1
    return json_file_count


def update_statistics(findings_for_file):
    global statistics_matrices
    for detector, findings in findings_for_file.items():
        for finding in findings:
            for other_detector, other_findings in findings_for_file.items():

                if other_detector == detector or REVERSE_MAPPING[detector]['category'] != REVERSE_MAPPING[other_detector]['category']:
                    continue
                for other_finding in other_findings:
                    if finding['function'] == other_finding['function']:
                        statistics_matrices[f"{REVERSE_MAPPING[detector]['category']}"][f"{detector}"][f"{other_detector}"] += 1


def process_json_file(json_file_path):
    with open(json_file_path, 'r') as file:
        data = json.load(file)

    # Dictionary to hold the processed information
    processed_info = {}

    # Loop through each file in the JSON
    for file_name, analysis_info in data.items():
        file_details = {}
        # Loop through each detector for the current file
        for detector, detector_info in analysis_info.items():
            # Check if the analysis was successful and vulnerability findings are not empty
            if detector_info.get("successfull_analysis", False) and detector_info.get("vulnerability_findings"):
                file_details[detector] = detector_info["vulnerability_findings"]

        # Only add details for this file if there are any non-empty findings
        if file_details:
            processed_info[file_name] = file_details

    # At this point, processed_info contains the extracted data without empty findings
    # You can process this data further as needed
    print(
        f"Processed vulnerabilties.json file of the following project => {json_file_path}:")
    for file, file_information in processed_info.items():
        relative_file_path = f"./DAppSCAN_processed{json_file_path[17:-21]}/{file}"
        findings_for_file = dict()
        for analyzer, analysis_results in file_information.items():
            # print(f"Analyzer is: {analyzer};")
            # print(analysis_results)
            for i in range(len(analysis_results)):
                vuln_start_line = analysis_results[i]["vulnerability_from_line"]
                vuln_end_line = analysis_results[i]["vulnerability_to_line"]
                vulnerability_name = analysis_results[i]["name"]
                # print(
                #    f"## Vulnerability is: {vulnerability_name}; vulnerability start line is: {vuln_start_line}; end line is: {vuln_end_line}")
                # print("* * * * * * * * * * * * * * * * * *")
                # print(
                #    f"start line: {vuln_start_line}, end line: {vuln_end_line}")
                if vuln_start_line == None:
                    if vuln_end_line == None:
                        break
                    else:
                        vuln_start_line = vuln_end_line
                elif vuln_end_line == None:
                    vuln_end_line = vuln_start_line

                # commenting for now, as I am doing another part of the code:
                output_json = compile_solidity_contract(relative_file_path)
                result = get_enclosing_function_and_contract(
                    output_json, relative_file_path, vuln_start_line, vuln_end_line)

                if vulnerability_name not in REVERSE_MAPPING:
                    continue
                # else:
                #     print(
                #         f">>> The {vulnerability_name} detector name is indeed in reverse mapping <<<")
                if vulnerability_name in findings_for_file:
                    findings_for_file[f"{vulnerability_name}"].append({
                        'function': result['function']['name'] if result['function'] is not None else result['function'],
                        'contract': result['contract']['name'] if result['contract'] is not None else result['contract'],
                    })
                else:
                    findings_for_file.update({
                        f"{vulnerability_name}": [{
                            'function': result['function']['name'] if result['function'] is not None else result['function'],
                            'contract': result['contract']['name'] if result['contract'] is not None else result['contract'],
                        },]
                    })
                # print(
                #    f"Contract is: {result['contract']}, Function is: {result['function']}")

        if findings_for_file:
            print(f"For file {file}; findings are: ")
            print(findings_for_file)
            update_statistics(findings_for_file)
            print('# # # # # # # # # # # # # # # # # #')
    print("------------------------------------------------------------ Project finished, moving to the next one ----------------------------------------------------------- ")

    # For demonstration, just returning the processed data

    return processed_info


def read_and_process_json_files(start_directory):
    for root, dirs, files in os.walk(start_directory):
        for file in files:
            if file == 'vulnerabilities.json':
                json_file_path = os.path.join(root, file)
                # Process the JSON file
                processed_data = process_json_file(json_file_path)
                # Add your processing code here, using the 'processed_data' variable


# Specify the start directory here
start_directory = '.'
read_and_process_json_files(start_directory)

print('\n ------------------------------ All supposed to be finished by this point ----------------------------------')
print(statistics_matrices['reentrancy'])
# result = get_enclosing_function_and_contract(
#    compile_solidity_contract('sample2.sol'), 'sample2.sol', 104, 109)
