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


        if (!PlayerManager.reloading)
        {
            if (PlayerManager.primaryGun && Input.GetKeyDown(KeyCode.Alpha1))
            {
                SwitchWeaponsFunction(PlayerManager.primaryGun);

            }
            else if (PlayerManager.secondaryGun && Input.GetKeyDown(KeyCode.Alpha2))
            {
                SwitchWeaponsFunction(PlayerManager.secondaryGun);
            }
        }
    }

    public static void SwitchWeaponsFunction(Gun gun)
    {
        if (gun.gunSO.type == Gun.GunType.Pistol)
        {
            //PlayerManager.primaryGun?.gameObject.SetActive(false);
            Instance.primaryGunTxt.fontSize = 25;
            Instance.secondaryGunTxt.fontSize = 45;
        }
        else
        {
            //PlayerManager.Instance.secondaryGun?.gameObject.SetActive(false);
            Instance.primaryGunTxt.fontSize = 45;
            Instance.secondaryGunTxt.fontSize = 25;
        }

        PlayerManager.equippedGun?.gameObject.SetActive(false);
        PlayerManager.equippedGun = gun;
        gun.gameObject.SetActive(true);
        gun.readyToFire = true;

        PlayerManager.SetGunUI(gun);

        PlayerManager.Instance.ammoBuyTxt.text = $"Refill {gun.gunSO.type} ammo for {gun.gunSO.ammoCost} points";
    }
}
