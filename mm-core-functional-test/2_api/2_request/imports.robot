*** Settings ***
Resource          ../2_request/common.robot
Resource          ../2_request/serviceA.robot
Resource          ../2_request/payment.robot
Resource          ../2_request/profile.robot
Library          ../2_request/post_import_whiteList.py
Resource          ../2_request/simulator.robot
Resource          ../2_request/payment_history.robot
Resource          ../2_request/customer_cdcn.robot

Resource          ../2_request/ekyc.robot