using UnityEngine;
using UnityEngine.UI;

public class SwitchWeapons : MonoBehaviour
{
    public static SwitchWeapons Instance;
    public Text primaryGunTxt, secondaryGunTxt;

    private void Awake()
    {
        Instance = this;
    }

    void Update()
    {
        primaryGunTxt.text = $"1. {(PlayerManager.primaryGun != null ? PlayerManager.primaryGun.gunSO.type.ToString() : "")}";
        //secondaryGunTxt.text = $"2. {(PlayerManager.Instance.secondaryGun != null ? PlayerManager.Instance.secondaryGun.type.ToString() : "")}";
        secondaryGunTxt.text = $"2. {PlayerManager.secondaryGun?.gunSO.type}";


        if (PlayerManager.switchingWeaponsAllowed && !PlayerManager.reloading)
        {
            if (Input.GetKeyDown(KeyCode.Alpha1))
            {
                SwitchWeaponsFunction(PlayerManager.GunSlot.Primary);

            }
            else if (Input.GetKeyDown(KeyCode.Alpha2))
            {
                SwitchWeaponsFunction(PlayerManager.GunSlot.Secondary);
            }
        }
    }

    public static void SwitchWeaponsFunction(PlayerManager.GunSlot slot)
    {
        PlayerManager.equippedGun?.gameObject.SetActive(false);

        if (slot == PlayerManager.GunSlot.Primary)
        {
            Instance.primaryGunTxt.fontSize = 45;
            Instance.secondaryGunTxt.fontSize = 25;
            PlayerManager.equippedGun = PlayerManager.primaryGun;
            PlayerManager.equippedGunSlot = PlayerManager.GunSlot.Primary;
        }
        else if (slot == PlayerManager.GunSlot.Secondary)
        {
            Instance.primaryGunTxt.fontSize = 25;
            Instance.secondaryGunTxt.fontSize = 45;
            PlayerManager.equippedGun = PlayerManager.secondaryGun;
            PlayerManager.equippedGunSlot = PlayerManager.GunSlot.Secondary;
        }

        if (!PlayerManager.equippedGun) return;

        PlayerManager.equippedGun.gameObject.SetActive(true);
        PlayerManager.equippedGun.readyToFire = true;

        PlayerManager.SetGunUI(PlayerManager.equippedGun);

        PlayerManager.Instance.ammoBuyTxt.text = $"Refill {PlayerManager.equippedGun.gunSO.type} ammo for {PlayerManager.equippedGun.gunSO.ammoCost} points";
    }
}
