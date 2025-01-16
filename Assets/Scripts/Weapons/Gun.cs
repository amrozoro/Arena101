using System.Collections;
using UnityEngine;

public class Gun : MonoBehaviour
{
    public enum GunType
    {
        Pistol = 0,
        Shotgun = 1000,
        M4A1 = 2000,
        AK47 = 3000,
    }

    public enum ShootingMode
    {
        Automatic,
        SemiAutomatic,
    }

    public GunSO gunSO;

    public Vector3 localPositionOffset;

    [HideInInspector] public AudioSource shootSound;
    [HideInInspector] public AudioSource reloadSound;


    private int _currentMagSize;
    public int currentMagSize
    {
        get { return _currentMagSize; }
        set
        {
            _currentMagSize = value;
            if (PlayerManager.equippedGun == this)
            {
                GameManager.magazineTxt.text = value.ToString();
            }
        }
    }


    private int _currentReserveSize;
    //TODO: change name to currentReserveSize
    public int currentReserveSize
    {
        get { return _currentReserveSize; }
        set
        {
            _currentReserveSize = value;
            if (PlayerManager.equippedGun == this)
            {
                GameManager.storageTxt.text = value.ToString();
            }
        }
    }

    [HideInInspector] public bool readyToFire = true;

    void Start()
    {
        currentMagSize = gunSO.maxMagSize;
        currentReserveSize = gunSO.maxStorageSize;
        transform.localPosition = localPositionOffset;
        readyToFire = true;
        PlayerManager.reloading = false;

        if(transform.CompareTag("AK-47") || transform.CompareTag("M4A1"))
        {
            shootSound = GameObject.Find("SFX").transform.GetChild(0).GetComponent<AudioSource>();
        }      
        else if (transform.CompareTag("Shotgun"))
        {
            shootSound = GameObject.Find("SFX").transform.GetChild(1).GetComponent<AudioSource>();
        }
        else if (transform.CompareTag("Pistol"))
        {
            shootSound = GameObject.Find("SFX").transform.GetChild(2).GetComponent<AudioSource>();
        }

        reloadSound = GameObject.Find("SFX").transform.GetChild(3).GetComponent<AudioSource>();
    }

    public void Update()
    {
        transform.rotation = GameObject.Find("Main Camera").GetComponent<Transform>().rotation;
    }

    public void Shoot()
    {
        currentMagSize--;
        PlayerStats.bulletsShot++;

        if(gunSO.shootingMode == ShootingMode.Automatic)
        {
            StartCoroutine(ShootDelay());
        }

        shootSound.Play();
    }

    IEnumerator ShootDelay()
    {
        readyToFire = false;
        yield return new WaitForSeconds(1/gunSO.fireRate);
        readyToFire = true;
    }

    public void Reload()
    {
        StartCoroutine(ReloadDelay());
    }

    IEnumerator ReloadDelay()
    {
        reloadSound.Play();
        readyToFire = false;
        PlayerManager.reloading = true; 

        yield return new WaitUntil(() => reloadSound.isPlaying == false);

        if ((currentReserveSize - (gunSO.maxMagSize - currentMagSize)) >= 0)
        {
            currentReserveSize = currentReserveSize - (gunSO.maxMagSize - currentMagSize);
            currentMagSize = gunSO.maxMagSize;
        }
        else
        {
            currentMagSize += currentReserveSize;
            currentReserveSize = 0;
        }

        PlayerManager.reloading = false;
        readyToFire = true;
    }

    public void CollectMaxAmmo()
    {
        currentMagSize = gunSO.maxMagSize;
        currentReserveSize = gunSO.maxStorageSize;
    }

    public bool IsAmmoFull()
    {
        return currentMagSize == gunSO.maxMagSize && currentReserveSize == gunSO.maxStorageSize;
    }
}