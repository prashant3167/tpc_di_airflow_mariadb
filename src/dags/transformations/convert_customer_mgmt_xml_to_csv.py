import xmltodict
import pandas as pd
from datetime import datetime
from sqlalchemy import create_engine
engine = create_engine("mysql+pymysql://tpcds:tpcds@host.docker.internal:3306/staging")

def prepare_char_insertion(field):
    if field == None:
        return None
    if field == "''":
        return ''
    # field = field.replace("'", "''")
    # field = field.replace('"', '\\"')
    return field

def prepare_non_null_char_insertion(field):
    print(field)
    if field == None:
        return "test"
    if field == "''":
        return "jj"
    # field = field.replace("'", "''")
    # field = field.replace('"', '\\"')
    return field
# def pre


def prepare_numeric_insertion(numeric):
    try:
        int(numeric)
        return numeric
    except:
        return None


s_customer_values = []


def make_contact(ct_code, area_code, local_code, c_ext):
    return f"""{ct_code if ct_code!=None else ''}{"("+area_code+")" if area_code!=None else ''}{local_code if local_code!=None else ""}{c_ext  if c_ext!=None else ""}"""


def xml_to_csv(input_file, output_file):
    df = pd.DataFrame(
        columns=[
            "ActionType",
            "ActionTS",
            "C_ID",
            "C_TAX_ID",
            "C_GNDR",
            "C_TIER",
            "C_DOB",
            "C_L_NAME",
            "C_F_NAME",
            "C_M_NAME",
            "C_ADLINE1",
            "C_ADLINE2",
            "C_ZIPCODE",
            "C_CITY",
            "C_STATE_PROV",
            "C_CTRY",
            "C_PRIM_EMAIL",
            "C_ALT_EMAIL",
            "C_PHONE_1_C_CTRY_CODE",
            "C_PHONE_1_C_AREA_CODE",
            "C_PHONE_1_C_LOCAL",
            "C_PHONE_1_C_EXT",
            "C_PHONE_2_C_CTRY_CODE",
            "C_PHONE_2_C_AREA_CODE",
            "C_PHONE_2_C_LOCAL",
            "C_PHONE_2_C_EXT",
            "C_PHONE_3_C_CTRY_CODE",
            "C_PHONE_3_C_AREA_CODE",
            "C_PHONE_3_C_LOCAL",
            "C_PHONE_3_C_EXT",
            "C_LCL_TX_ID",
            "C_NAT_TX_ID",
            "CA_ID",
            "CA_TAX_ST",
            "CA_B_ID",
            "CA_NAME",
        ]
    )
    with open(input_file) as fd:
        doc = xmltodict.parse(fd.read())
        actions = doc["TPCDI:Actions"]["TPCDI:Action"]
        for action in actions:
            ActionType = prepare_char_insertion(action["@ActionType"])
            # print(ActionType)
            # print(action["@ActionTS"])
            ActionTS = datetime.strptime(action["@ActionTS"],"%Y-%m-%dT%H:%M:%S")
            C_ID = prepare_numeric_insertion(action["Customer"]["@C_ID"])
            C_TAX_ID = (
                C_GNDR
            ) = (
                C_TIER
            ) = (
                C_DOB
            ) = (
                C_L_NAME
            ) = (
                C_F_NAME
            ) = (
                C_M_NAME
            ) = C_ADLINE1 = C_ADLINE2 = C_ZIPCODE = C_CITY = C_STATE_PROV = C_CTRY = None
            C_TIER = None
            try:
                C_TAX_ID = prepare_char_insertion(action["Customer"]["@C_TAX_ID"])
            except:
                pass
            try:
                C_GNDR = prepare_char_insertion(action["Customer"]["@C_GNDR"])
            except:
                pass
            try:
                C_TIER = prepare_numeric_insertion(action["Customer"]["@C_TIER"])
            except:
                pass
            try:
                C_DOB = datetime.strptime(action["Customer"]["@C_DOB"],"%Y-%m-%d").date()
            except:
                pass
            try:
                C_L_NAME = prepare_char_insertion(
                    action["Customer"]["Name"]["C_L_NAME"]
                )
            except:
                pass
            try:
                C_F_NAME = prepare_char_insertion(
                    action["Customer"]["Name"]["C_F_NAME"]
                )
            except:
                pass
            try:
                C_M_NAME = prepare_char_insertion(
                    action["Customer"]["Name"]["C_M_NAME"]
                )
            except:
                pass
            try:
                C_ADLINE1 = prepare_char_insertion(
                    action["Customer"]["Address"]["C_ADLINE1"]
                )
            except:
                pass
            try:
                C_ADLINE2 = prepare_char_insertion(
                    action["Customer"]["Address"]["C_ADLINE2"]
                )
            except:
                pass
            try:
                C_ZIPCODE = prepare_non_null_char_insertion(
                    action["Customer"]["Address"]["C_ZIPCODE"]
                )
                # print(C_ZIPCODE)
            except:
                pass
            try:
                C_CITY = prepare_char_insertion(action["Customer"]["Address"]["C_CITY"])
            except:
                pass
            try:
                C_STATE_PROV = prepare_char_insertion(
                    action["Customer"]["Address"]["C_STATE_PROV"]
                )
            except:
                pass
            try:
                C_CTRY = prepare_char_insertion(action["Customer"]["Address"]["C_CTRY"])
            except:
                pass
            C_PRIM_EMAIL = (
                C_ALT_EMAIL
            ) = (
                C_PHONE_1_C_CTRY_CODE
            ) = (
                C_PHONE_1_C_AREA_CODE
            ) = (
                C_PHONE_1_C_LOCAL
            ) = (
                C_PHONE_2_C_CTRY_CODE
            ) = (
                C_PHONE_2_C_AREA_CODE
            ) = (
                C_PHONE_2_C_LOCAL
            ) = (
                C_PHONE_3_C_CTRY_CODE
            ) = (
                C_PHONE_3_C_AREA_CODE
            ) = (
                C_PHONE_3_C_LOCAL
            ) = C_PHONE_1_C_EXT = C_PHONE_2_C_EXT = C_PHONE_3_C_EXT = None
            try:
                C_PRIM_EMAIL = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_PRIM_EMAIL"]
                )
            except:
                pass
            try:
                C_ALT_EMAIL = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_ALT_EMAIL"]
                )
            except:
                pass
            try:
                C_PHONE_1_C_EXT = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_PHONE_1"]["C_EXT"]
                )
            except:
                pass
            try:
                C_PHONE_1_C_LOCAL = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_PHONE_1"]["C_LOCAL"]
                )
            except:
                pass
            try:
                C_PHONE_1_C_AREA_CODE = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_PHONE_1"]["C_AREA_CODE"]
                )
            except:
                pass
            try:
                C_PHONE_1_C_CTRY_CODE = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_PHONE_1"]["C_CTRY_CODE"]
                )
            except:
                pass
            try:
                C_PHONE_2_C_EXT = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_PHONE_2"]["C_EXT"]
                )
            except:
                pass
            try:
                C_PHONE_2_C_LOCAL = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_PHONE_2"]["C_LOCAL"]
                )
            except:
                pass
            try:
                C_PHONE_2_C_AREA_CODE = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_PHONE_2"]["C_AREA_CODE"]
                )
            except:
                pass
            try:
                C_PHONE_2_C_CTRY_CODE = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_PHONE_2"]["C_CTRY_CODE"]
                )
            except:
                pass
            try:
                C_PHONE_3_C_EXT = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_PHONE_3"]["C_EXT"]
                )
            except:
                pass
            try:
                C_PHONE_3_C_LOCAL = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_PHONE_3"]["C_LOCAL"]
                )
            except:
                pass
            try:
                C_PHONE_3_C_AREA_CODE = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_PHONE_3"]["C_AREA_CODE"]
                )
            except:
                pass
            try:
                C_PHONE_3_C_CTRY_CODE = prepare_char_insertion(
                    action["Customer"]["ContactInfo"]["C_PHONE_3"]["C_CTRY_CODE"]
                )
            except:
                pass
            C_LCL_TX_ID = C_NAT_TX_ID = None
            try:
                C_LCL_TX_ID = prepare_char_insertion(
                    action["Customer"]["TaxInfo"]["C_LCL_TX_ID"]
                )
                C_NAT_TX_ID = prepare_char_insertion(
                    action["Customer"]["TaxInfo"]["C_NAT_TX_ID"]
                )
            except:
                pass
            CA_ID = None
            try:
                CA_ID = prepare_numeric_insertion(
                    action["Customer"]["Account"]["@CA_ID"]
                )
            except:
                pass
            CA_TAX_ST = None
            try:
                CA_TAX_ST = prepare_numeric_insertion(
                    action["Customer"]["Account"]["@CA_TAX_ST"]
                )
            except:
                pass
            CA_B_ID = None
            try:
                CA_B_ID = prepare_numeric_insertion(
                    action["Customer"]["Account"]["CA_B_ID"]
                )
            except:
                pass
            CA_NAME = None
            try:
                CA_NAME = prepare_char_insertion(
                    action["Customer"]["Account"]["CA_NAME"]
                )
            except:
                pass
            # print([ActionType, ActionTS])
            s_customer_values.append(
                [
                    ActionType,
                    ActionTS,
                    C_ID,
                    C_TAX_ID,
                    C_GNDR,
                    C_TIER,
                    C_DOB,
                    C_L_NAME,
                    C_F_NAME,
                    C_M_NAME,
                    C_ADLINE1,
                    C_ADLINE2,
                    C_ZIPCODE,
                    C_CITY,
                    C_STATE_PROV,
                    C_CTRY,
                    C_PRIM_EMAIL,
                    C_ALT_EMAIL,
                    C_PHONE_1_C_CTRY_CODE,
                    C_PHONE_1_C_AREA_CODE,
                    C_PHONE_1_C_LOCAL,
                    C_PHONE_1_C_EXT,
                    C_PHONE_2_C_CTRY_CODE,
                    C_PHONE_2_C_AREA_CODE,
                    C_PHONE_2_C_LOCAL,
                    C_PHONE_2_C_EXT,
                    C_PHONE_3_C_CTRY_CODE,
                    C_PHONE_3_C_AREA_CODE,
                    C_PHONE_3_C_LOCAL,
                    C_PHONE_3_C_EXT,
                    C_LCL_TX_ID,
                    C_NAT_TX_ID,
                    CA_ID,
                    CA_TAX_ST,
                    CA_B_ID,
                    CA_NAME,
                ]
            )
    df = pd.DataFrame(
        s_customer_values,
        columns=[
            "ActionType",
            "ActionTS",
            "C_ID",
            "C_TAX_ID",
            "C_GNDR",
            "C_TIER",
            "C_DOB",
            "C_L_NAME",
            "C_F_NAME",
            "C_M_NAME",
            "C_ADLINE1",
            "C_ADLINE2",
            "C_ZIPCODE",
            "C_CITY",
            "C_STATE_PROV",
            "C_CTRY",
            "C_PRIM_EMAIL",
            "C_ALT_EMAIL",
            "C_PHONE_1_C_CTRY_CODE",
            "C_PHONE_1_C_AREA_CODE",
            "C_PHONE_1_C_LOCAL",
            "C_PHONE_1_C_EXT",
            "C_PHONE_2_C_CTRY_CODE",
            "C_PHONE_2_C_AREA_CODE",
            "C_PHONE_2_C_LOCAL",
            "C_PHONE_2_C_EXT",
            "C_PHONE_3_C_CTRY_CODE",
            "C_PHONE_3_C_AREA_CODE",
            "C_PHONE_3_C_LOCAL",
            "C_PHONE_3_C_EXT",
            "C_LCL_TX_ID",
            "C_NAT_TX_ID",
            "CA_ID",
            "CA_TAX_ST",
            "CA_B_ID",
            "CA_NAME",
        ],
    )
    df["Phone1"] = df.apply(
        lambda x: make_contact(
            x.C_PHONE_1_C_CTRY_CODE,
            x.C_PHONE_1_C_AREA_CODE,
            x.C_PHONE_1_C_LOCAL,
            x.C_PHONE_1_C_EXT,
        ),
        axis=1,
    )
    df["Phone2"] = df.apply(
        lambda x: make_contact(
            x.C_PHONE_2_C_CTRY_CODE,
            x.C_PHONE_2_C_AREA_CODE,
            x.C_PHONE_2_C_LOCAL,
            x.C_PHONE_2_C_EXT,
        ),
        axis=1,
    )
    df["Phone3"] = df.apply(
        lambda x: make_contact(
            x.C_PHONE_3_C_CTRY_CODE,
            x.C_PHONE_3_C_AREA_CODE,
            x.C_PHONE_3_C_LOCAL,
            x.C_PHONE_3_C_EXT,
        ),
        axis=1,
    )
    df["Status"] = df.apply(
        lambda x: "INACTIVE" if x.ActionType == "INACT" else "ACTIVE", axis=1
    )

    df = df.drop(
        columns=[
            "C_PHONE_1_C_CTRY_CODE",
            "C_PHONE_1_C_AREA_CODE",
            "C_PHONE_1_C_LOCAL",
            "C_PHONE_1_C_EXT",
            "C_PHONE_2_C_CTRY_CODE",
            "C_PHONE_2_C_AREA_CODE",
            "C_PHONE_2_C_LOCAL",
            "C_PHONE_2_C_EXT",
            "C_PHONE_3_C_CTRY_CODE",
            "C_PHONE_3_C_AREA_CODE",
            "C_PHONE_3_C_LOCAL",
            "C_PHONE_3_C_EXT",
        ]
    )
    df = df.rename(
        columns={
            "ActionType": "Action",
            "ActionTS": "effective_time_stamp",
            "Phone1": "Phone1",
            "Phone2": "Phone2",
            "Phone3": "Phone3",
            "C_TIER": "TIER",
            "C_ID": "CustomerID",
            "C_GNDR": "Gender",
            "C_PRIM_EMAIL": "Email1",
            "C_ALT_EMAIL": "Email2",
            "C_TAX_ID": "TAXID",
            "C_DOB": "DOB",
            "C_F_NAME": "FirstName",
            "C_M_NAME": "MiddleInitial",
            "C_L_NAME": "LastName",
            "C_CTRY": "Country",
            "C_CITY": "City",
            "C_ZIPCODE": "PostalCode",
            "C_ADLINE1": "AddressLine1",
            "C_ADLINE2": "AddressLine2",
            "C_STATE_PROV": "State_Prov",
            "Status": "Status",
            "C_NAT_TX_ID": "NationalTaxID",
            "CA_TAX_ST": "TaxStatus",
            "CA_NAME": "AccountDesc",
            "CA_B_ID": "BrokerID",
            "CA_ID": "AccountID",
            "C_LCL_TX_ID": "LocalTaxID",
        }
    )
    df["effective_time_stamp"] = pd.to_datetime(df["effective_time_stamp"])
    # df.to_csv(output_file, index=False, header=False, doublequote=True)
    # print(df.PostalCode.drop_duplicates())
    df.PostalCode = df.PostalCode.fillna('')
    # C_ADLINE1
    df.AddressLine1 = df.AddressLine1.fillna('')
    df.City = df.City.fillna('')
    df.State_Prov  = df.State_Prov.fillna('')
    df.to_sql('customer_management',engine,if_exists='append',index=False)
    


# xml_to_csv('/Users/Licious/project/ulb/dw/di/data_3/Batch1/CustomerMgmt.xml','/Users/Licious/project/ulb/dw/di/data_3/Batch1/CustomerMgmt.csv')