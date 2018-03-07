#!/bin/python

if 'CRITICAL WARNING: [Timing 38-282] The design failed to meet the timing requirements. Please see the timing summary report for details on the timing violations.' in open('top/top.runs/impl_1/runme.log').read():
    print '\x1b[31;01m', '[CRITICAL ERROR] Timing closure was not achieved!', '\x1b[39;49;00m'
    exit(1)
else:
    print 'TIMING OK'
    exit(0)
