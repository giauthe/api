*** Settings ***
Resource          ../1_common/imports.robot

*** Keywords ***
[prepare] Data for router db
    [Prepare][Router] Data for corridor table
#    [Prepare][Router] Data for corridor_currency_mapping table
#    [Prepare][Router] Data for corridor_partner_mapping table
#    [Prepare][Router] Data for route table

#[Prepare][Router] Data for corridor table
#    [Arguments]
#        ...     ${start_index}=1
#        ...     ${end_index}=6
#    FOR    ${index}   IN RANGE    ${start_index}      ${end_index}
#         Execute Sql String     DELETE from corridor where id=${corridor_id_${index}}
#         Execute Sql String     INSERT INTO corridor (id, country_code, country_name, transaction_type, direction) VALUES (${corridor_id_${index}},'${ corridor_country_code_${index}}', '${corridor_country_name_${index}}', '${corridor_transaction_type_${index}}', '${corridor_direction_${index}}');
#    END
#
#[Prepare][Router] Data for corridor_currency_mapping table
#    [Arguments]
#        ...     ${start_index}=1
#        ...     ${end_index}=5
#    FOR    ${index}   IN RANGE    ${start_index}      ${end_index}
#         Execute Sql String     DELETE from corridor_currency_mapping where id=${corridorCurrency_id_${index}}
#         Execute Sql String     INSERT INTO corridor_currency_mapping (id, corridor_id, currency_code) VALUES (${corridorCurrency_id_${index}},'${ corridorCurrency_corridor_id_${index}}', '${corridorCurrency_currency_code_${index}}');
#    END
#
#[Prepare][Router] Data for corridor_partner_mapping table
#    [Arguments]
#        ...     ${start_index}=1
#        ...     ${end_index}=5
#    FOR    ${index}   IN RANGE    ${start_index}      ${end_index}
#         Execute Sql String     DELETE from corridor_partner_mapping where id=${corridorPartner_id_${index}}
#         Execute Sql String     INSERT INTO corridor_partner_mapping (id, corridor_id, partner_code) VALUES (${corridorPartner_id_${index}},'${corridorPartner_corridor_id_${index}}', '${corridorPartner_partner_code_${index}}');
#    END
#
#[Prepare][Router] Data for route table
#    [Arguments]
#        ...     ${start_index}=1
#        ...     ${end_index}=3
#    FOR    ${index}   IN RANGE    ${start_index}      ${end_index}
#         Execute Sql String     DELETE from route where id=${corridorPartner_id_${index}}
#         Execute Sql String     INSERT INTO route (id, sender_partner_code, sender_corridor_id, receiver_partner_code, receiver_corridor_id, transaction_type, currency_code) VALUES (${route_id_${index}},'${route_sender_partner_code_${index}}', '${route_sender_corridor_id_${index}}','${route_receiver_partner_code_${index}}','${route_receiver_corridor_id_${index}}','${route_transaction_type_${index}}','${route_currency_code_${index}}');
#    END


[Prepare][Router] Data for corridor table
    [Arguments]
        ...     ${start_index}=1
        ...     ${end_index}=3
    FOR    ${index}   IN RANGE    ${start_index}      ${end_index}
         Execute Sql String     INSERT INTO corridor (id, sender_country_code, sender_partner_code, receiver_partner_code, receiver_country_code, transaction_type, currency_code) VALUES (${corridor_id_${index}},'${ corridor_sender_country_code_${index}}', '${corridor_sender_partner_code_${index}}', '${corridor_receiver_partner_code_${index}}', '${corridor_receiver_country_code_${index}}', '${corridor_transaction_type_${index}}', '${corridor_currency_code_${index}}') ON CONFLICT (id) DO NOTHING;
    END

