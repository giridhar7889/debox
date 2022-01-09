from brownie import boxProperty, accounts, network
import os


def main():
    test()


def test():
    account = get_account()

    box_property = boxProperty.deploy(account, 100, 78, {"from": account})
    # box_property = boxProperty[-1]
    tenant_address = "0xEF84BD25a96AD98b386afD91807a642d697379D6"
    Tenant = box_property.createTenantRightAgreement(
        tenant_address, 2, 12, {"from": account}
    )
    print(box_property.isAvailable())

    print(box_property.Tenant_address({"from": account}))


def get_account():

    return accounts.add("0x" + os.getenv("PRIVATE_KEY"))
