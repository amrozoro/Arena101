using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class GameManager : MonoBehaviour
{
    public static GameManager Instance;

    public GameObject pauseMenu, pauseMenuButtons, pauseMenuVolumePage;
    public GameObject playerUI, statsMenu, buyMenu, doubleJumpBuy, doubleJumpText;
    public GameObject enemyPrefab, weapons;

    public GameObject[] gunPrefabs = new GameObject[4];

    public GameObject[] powerups = new GameObject[3];

    public AudioSource[] music;

    public static Text magazineTxt, storageTxt;
    public Text roundNumberText, enemiesLeftText, prepPhaseText, akBuyText, m4BuyText, shotgunBuyText;

    public Text doublePointsTxt, instaKillTxt;

    public AudioSource gunBuySound, spawnSound;


    private static bool _gameIsPaused = false;
    public static bool gameIsPaused
    {
        get { return _gameIsPaused; }
        set
        {
            _gameIsPaused = value;

            PlayerManager.lookingAroundAllowed = !value;
            PlayerManager.movementAllowed = !value;
            PlayerManager.shootingAllowed = !value;
            PlayerManager.reloadingAllowed = !value;
            PlayerManager.switchingWeaponsAllowed = !value;
        }
    }

    private static bool _buyMenuOpen = false;
    public static bool buyMenuOpen
    {
        get { return _buyMenuOpen; }
        set
        {
            _buyMenuOpen = value;

            PlayerManager.lookingAroundAllowed = !value;
            PlayerManager.shootingAllowed = !value;
            PlayerManager.reloadingAllowed = !value;
        }
    }

    public static bool gameOver = false;
    public bool roundPlaying = true;
    public int prepPhaseDuration = 5;
    int prepPhaseTimeLeft = 10;
    
    public GameObject enemiesHolder;

    private void Awake()
    {
        Instance = this;
    }

    void Start()
    {
        playerUI.SetActive(true);
        buyMenu.SetActive(false);
        pauseMenu.SetActive(false);
        statsMenu.SetActive(false);

        gameOver = false;
        buyMenuOpen = false;
        roundPlaying = true;
        PlayerManager.currentPoints = 1000;
        ResumeGame();
        magazineTxt = GameObject.Find("Magazine").GetComponent<Text>();
        storageTxt = GameObject.Find("Storage").GetComponent<Text>();
        PlayerStats.roundsSurvived = 0;
        PlayerStats.enemiesKilled = 0;
        PlayerStats.bulletsShot = 0;
        PlayerStats.pointsEarned = 0;
        StartCoroutine(MusicPlayer());

        SpawnGun(Gun.GunType.Pistol);
    }

    void Update()
    {
        if(GameObject.Find("Enemies").transform.childCount == 0 && roundPlaying)
        {
            StartCoroutine(StartRound());
        }

        roundNumberText.text = "Round " + PlayerStats.roundsSurvived;
        enemiesLeftText.text = GameObject.Find("Enemies").transform.childCount.ToString();

        PowerupTxtUpdater();

        if (gameOver)
        {
            SceneManager.LoadScene("GameOver");
        }

        if (Input.GetKeyDown(KeyCode.Escape) && !gameIsPaused)
        {
            PauseGame();
        }
        else if (Input.GetKeyDown(KeyCode.Escape) && gameIsPaused)
        {
            ResumeGame();
        }
        
        if(Input.GetKeyDown(KeyCode.Tab) && !gameIsPaused && !buyMenuOpen)
        {
            buyMenu.SetActive(true);
            buyMenuOpen = true;
            playerUI.SetActive(false);
            Cursor.lockState = CursorLockMode.None;
            Cursor.visible = true;
        }
        else if (Input.GetKeyDown(KeyCode.Tab) && !gameIsPaused && buyMenuOpen)
        {
            buyMenu.SetActive(false);
            buyMenuOpen = false;
            playerUI.SetActive(true);
            Cursor.lockState = CursorLockMode.Locked;
            Cursor.visible = false;
        }
    }

    private void PowerupTxtUpdater()
    {
        if (PlayerManager.doublePointsOn)
        {
            doublePointsTxt.text = "Double Points: " + PlayerManager.doublePointsRemainingTime.ToString();
            doublePointsTxt.gameObject.SetActive(true);
        }
        else
        {
            doublePointsTxt.gameObject.SetActive(false);
        }
        if (PlayerManager.instaKillOn)
        {
            instaKillTxt.text = "Insta Kill: " + PlayerManager.instaKillRemainingTime.ToString();
            instaKillTxt.gameObject.SetActive(true);
        }
        else
        {
            instaKillTxt.gameObject.SetActive(false);
        }
    }

    public void PauseGame()
    {
        gameIsPaused = true;
        Time.timeScale = 0f;
        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = true;
        pauseMenu.SetActive(true);
        pauseMenuButtons.SetActive(true);
        playerUI.SetActive(false);
        buyMenu.SetActive(false);
    }

    public void ResumeGame()
    {
        gameIsPaused = false;
        Time.timeScale = 1f;
        Cursor.lockState = CursorLockMode.Locked; // Locks the mouse cursor to the center of the game screen and hides it
        Cursor.visible = false;
        pauseMenuVolumePage.SetActive(false);
        statsMenu.SetActive(false);
        pauseMenu.SetActive(false);
        playerUI.SetActive(true);
    }

    public void QuitToStartMenu()
    {
        SceneManager.LoadScene("StartMenu");
    }

    public void QuitGame()
    {
        Application.Quit();
    }

    private void BuyGun(Gun.GunType type)
    {
        if (PlayerManager.currentPoints >= (int)type && PlayerManager.primaryGun?.gunSO.type != type)
        {
            PlayerManager.currentPoints -= (int)type;
            SpawnGun(type);
            gunBuySound.Play();
        }
    }

    public void SpawnGun(Gun.GunType type)
    {
        Gun gunScript = null;

        foreach (GameObject g in gunPrefabs)
        {
            if (g.GetComponent<Gun>().gunSO.type == type)
            {
                var gun = Instantiate(g, weapons.transform);
                gunScript = gun.GetComponent<Gun>();
                break;
            }
        }

        if (PlayerManager.equippedGunSlot == PlayerManager.GunSlot.Primary)
        {
            Destroy(PlayerManager.primaryGun?.gameObject);
            PlayerManager.primaryGun = gunScript;
            SwitchWeapons.SwitchWeaponsFunction(PlayerManager.GunSlot.Primary);
        }
        else if (PlayerManager.equippedGunSlot == PlayerManager.GunSlot.Secondary)
        {
            Destroy(PlayerManager.secondaryGun?.gameObject);
            PlayerManager.secondaryGun = gunScript;
            SwitchWeapons.SwitchWeaponsFunction(PlayerManager.GunSlot.Secondary);
        }

    }

    public void BuyAK47()
    {
        BuyGun(Gun.GunType.AK47);
    }

    public void BuyM4A1()
    {
        BuyGun(Gun.GunType.M4A1);
    }

    public void BuyShotgun()
    {
        BuyGun(Gun.GunType.Shotgun);
    }

    public void BuyAmmo()
    {
        if (PlayerManager.currentPoints >= PlayerManager.equippedGun.gunSO.ammoCost && !PlayerManager.equippedGun.IsAmmoFull())
        {
            PlayerManager.currentPoints -= PlayerManager.equippedGun.gunSO.ammoCost;

            RefillAmmo(PlayerManager.equippedGun);

            gunBuySound.Play();
        }
    }

    public void RefillAmmo(Gun gun)
    {
        gun.currentMagSize = gun.gunSO.maxMagSize;
        gun.currentReserveSize = gun.gunSO.maxStorageSize;
    }

    public void BuyDoubleJumpSkill()
    {
        if (PlayerManager.currentPoints >= 6000)
        {
            PlayerManager.currentPoints -= 6000;
            PlayerManager.jumpsAllowed *= 2;
            doubleJumpBuy.GetComponent<Button>().enabled = false;
            doubleJumpBuy.GetComponentInChildren<Text>().text = "Double Jump Already Acquired";
            doubleJumpText.SetActive(true);
        }
    }

    IEnumerator StartRound()
    {
        roundPlaying = false;
        prepPhaseText.gameObject.SetActive(true);

        for (int i = 1; i <= prepPhaseDuration; i++)
        {
            yield return new WaitForSeconds(1);
            prepPhaseTimeLeft = prepPhaseDuration - i;
            prepPhaseText.text = "Prep for next round " + prepPhaseTimeLeft.ToString();
        }

        prepPhaseText.text = "Prep for next round " + prepPhaseDuration.ToString();
        prepPhaseText.gameObject.SetActive(false);
        PlayerStats.roundsSurvived++;

        int enemyCount = PlayerStats.roundsSurvived;

        for (int i = 0; i < enemyCount; i++)
        {
            //spawns enemies in batches of 5
            if (i != 0 && i % 5 == 0)
            {
                yield return new WaitForSeconds(0.5f);
            }

            int direction = i % 4;

            int separation = 4;

            float x = 0, z = 0;

            if (direction == 0 || direction == 1)
            {
                x = -separation * (enemyCount / 2 - i) + (enemyCount > 1 ? separation / 2 : 0);
                z = direction == 0 ? 110 : -110;
            }
            else if (direction == 2 || direction == 3)
            {
                x = direction == 2 ? 110 : -110;
                z = -separation * (enemyCount / 2 - i) + (enemyCount > 1 ? separation / 2 : 0);
            }


            GameObject enemy = Instantiate(enemyPrefab, enemiesHolder.transform);
            enemy.transform.position = new Vector3(x, enemy.transform.position.y, z);
        }

        roundPlaying = true;
        spawnSound.Play();
    }

    IEnumerator MusicPlayer()
    {
        while (!gameOver)
        {
            AudioSource currentSong = music[Random.Range(0, music.Length)];
            currentSong.Play();
            yield return new WaitUntil(() => currentSong.isPlaying == false);
        }
    }
}