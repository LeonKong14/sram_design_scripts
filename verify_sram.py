import yaml

def run_test():
    with open("test_data.yaml", "r") as f:
        data = yaml.safe_load(f)

    mem = [0] * 16  #16x8=128 bits 

    #only handle entries with 'addr' key
    for test in data["tests"]:
        if "addr" in test and "write_data" in test:
            addr = test["addr"]
            write_data = test["write_data"]
            mem[addr] = write_data
            print(f"Write {hex(write_data)} to address {addr}")

    #find the test with 'read_addrs' key
    for test in data["tests"]:
        if "read_addrs" in test:
            for addr in test["read_addrs"]:
                read_data = mem[addr]
                print(f"Read from address {addr}: {hex(read_data)}")

if __name__ == "__main__":
    run_test()