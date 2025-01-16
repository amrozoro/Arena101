using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class PlayerManager : MonoBehaviour
{
    public static PlayerManager Instance;
    [Range(1, 100)] public float mouseSensitivityX = 70, mouseSensitivityY = 70;
    public GameObject mainCamera;
    public Text healthTxt, currentPointsTxt, sprintText, doublePointsText, instaKillText, doubleJumpText, buyMenuPointsTxt, ammoBuyTxt, magazineTxt, storageTxt;

    public Rigidbody rigidbodyComponent;
    public ConstantForce constantForceComponent;
    
    public AudioSource jumpSound, maxAmmoSound, doublePointsSound, instaKillSound, takeDamageSound;

    public static float normalSpeed { get; private set; } = 15;
    public static float sprintSpeed { get; private set; } = normalSpeed * 1.5f;
    public static float superSpeed { get; private set; } = normalSpeed * 3.0f;
    public static float currentSpeed { get; private set; }

    float jumpForce = 40f;
    float gravityOnGround = -9.81f;
    float gravityInAir = -100f;
    bool isOnGround = true;

    private static int _healthPoints;

    public static int healthPoints
    {
        get { return _healthPoints; }
        set
        {
            _healthPoints = value;

            if (value > 0)
            {
                Instance.healthTxt.text = $"Health: {value}";
            }
            else
            {
                Instance.healthTxt.text = "Health: 0";
                GameManager.gameOver = true;
            }
        }
    }


    public int jumpsLeft = 1;

    public static int originalPointsPerEnemyHit = 10;
    public static int pointsPerEnemyHit = originalPointsPerEnemyHit;

    public static int originalPointsPerEnemyKill = 100;
    public static int pointsPerEnemyKill = originalPointsPerEnemyKill;

    public static int jumpsAllowed = 1;

    private static int _currentPoints;

    public static int currentPoints
    {
        get { return _currentPoints; }
        set 
        {
            _currentPoints = value;
            Instance.currentPointsTxt.text = Instance.buyMenuPointsTxt.text = $"Points: {value}";
        }
    }

    public static int doublePointsDuration = 30;
    public static int doublePointsRemainingTime = doublePointsDuration;
    public static int instaKillDuration = 15;
    public static int instaKillRemainingTime = instaKillDuration;

    public static bool reloading = false;
    public static bool doublePointsOn = false;
    public static bool instaKillOn = false;

    public static Gun primaryGun;
    public static Gun secondaryGun;
    public static Gun equippedGun;

    public static bool movementAllowed = true;
    public static bool jumpingAllowed = true;
    public static bool lookingAroundAllowed = true;
    public static bool shootingAllowed = true;
    public static bool reloadingAllowed = true;
    public static bool switchingWeaponsAllowed = true;

    public static KeyCode jumpKey
    {
        get;
        private set;
    } = KeyCode.Space;

    private void Awake()
    {
        Instance = this;
        healthPoints = 100;
    }

    void Update()
    {
        if (movementAllowed)
        {
            Move();

            if (jumpingAllowed && jumpsLeft > 0 && Input.GetKeyDown(jumpKey))
            {
                Jump();
            }

        }

        if (lookingAroundAllowed)
        {
            LookAround();
        }

        if (shootingAllowed)
        {
            if (equippedGun?.gunSO.shootingMode == Gun.ShootingMode.Automatic)
            {
                if (Input.GetKey(KeyCode.Mouse0) && equippedGun.currentMagSize > 0 && equippedGun.readyToFire && !reloading && equippedGun.readyToFire)
                {
                    equippedGun.GetComponent<Gun>().Shoot();

                    RaycastHit hitInfo;

                    if (Physics.Raycast(CameraController.currentActiveCam.ScreenPointToRay(Input.mousePosition), out hitInfo))
                    {
                        if (hitInfo.collider.CompareTag("Enemy"))
                        {
                            currentPoints += pointsPerEnemyHit;
                            PlayerStats.pointsEarned += pointsPerEnemyHit;

                            if (hitInfo.collider.GetComponent<EnemyManager>()) // if ray hits body of enemy
                            {
                                if (instaKillOn)
                                {
                                    hitInfo.collider.GetComponent<EnemyManager>().TakeDamage(10000);
                                }
                                else
                                {
                                    hitInfo.collider.GetComponent<EnemyManager>().TakeDamage(equippedGun.gunSO.damage);
                                }
                            }
                            else // If ray hits eye of enemy
                            {
                                if (instaKillOn)
                                {
                                    hitInfo.collider.GetComponentInParent<EnemyManager>().TakeDamage(10000);
                                }
                                else
                                {
                                    hitInfo.collider.GetComponentInParent<EnemyManager>().TakeDamage(equippedGun.gunSO.damage);
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                if (Input.GetKeyDown(KeyCode.Mouse0) && equippedGun.currentMagSize > 0 && equippedGun.readyToFire && !reloading && equippedGun.readyToFire)
                {
                    equippedGun.GetComponent<Gun>().Shoot();

                    RaycastHit hitInfo;

                    if (Physics.Raycast(CameraController.currentActiveCam.ScreenPointToRay(Input.mousePosition), out hitInfo))
                    {
                        if (hitInfo.collider.CompareTag("Enemy"))
                        {
                            currentPoints += pointsPerEnemyHit;
                            PlayerStats.pointsEarned += pointsPerEnemyHit;

                            if (hitInfo.collider.GetComponent<EnemyManager>()) // if ray hits body of enemy
                            {
                                if (instaKillOn)
                                {
                                    hitInfo.collider.GetComponent<EnemyManager>().TakeDamage(10000);
                                }
                                else
                                {
                                    hitInfo.collider.GetComponent<EnemyManager>().TakeDamage(equippedGun.gunSO.damage);
                                }
                            }
                            else // If ray hits eye of enemy
                            {
                                if (instaKillOn)
                                {
                                    hitInfo.collider.GetComponentInParent<EnemyManager>().TakeDamage(10000);
                                }
                                else
                                {
                                    hitInfo.collider.GetComponentInParent<EnemyManager>().TakeDamage(equippedGun.gunSO.damage);
                                }
                            }
                        }
                    }
                }
            }
        }

        if (reloadingAllowed && Input.GetKeyDown(KeyCode.R) && equippedGun.currentMagSize != equippedGun.gunSO.maxMagSize && equippedGun.currentReserveSize > 0 && !reloading)
        {
            equippedGun.Reload();
        }
    }

    void Move()
    {
        if (Input.GetKey(KeyCode.LeftShift) && isOnGround)
        {
            currentSpeed = sprintSpeed;
            sprintText.gameObject.SetActive(true);
        }
        else
        {
            currentSpeed = normalSpeed;
            sprintText.gameObject.SetActive(false);
        }

        Vector3 moveInput = new Vector3(Input.GetAxisRaw("Horizontal"), 0, Input.GetAxisRaw("Vertical")); 
        Vector3 direction = moveInput.normalized;
        Vector3 velocity = direction * currentSpeed; 

        transform.Translate(velocity * Time.deltaTime);
    }

    void LookAround()
    {
        float mouseX = Input.GetAxis("Mouse X") * mouseSensitivityX * Time.deltaTime; // Gets input from the mouse on the horizontal (x) axis. Returns 0 for no input, 1 for positive input, and -1 for negative input
        float mouseY = Input.GetAxis("Mouse Y") * mouseSensitivityY * Time.deltaTime; // Gets input from the mouse on the vertical (y) axis. Returns 0 for no input, 1 for positive input, and -1 for negative input

        transform.Rotate(0, mouseX, 0); // Rotates player around y axis (left to right) depending on mouse input

        Camera cam = CameraController.currentActiveCam;
        cam.transform.Rotate(-mouseY, 0, 0); // Rotates Main Camera around x axis (up and down) depending on mouse 

        //float xVal = Mathf.Clamp(cam.transform.eulerAngles.x, -90, 90);

        //cam.transform.eulerAngles = new Vector3(xVal, 0, 0);
    }

    void Jump()
    {
        isOnGround = false;
        jumpsLeft--;
        rigidbodyComponent.AddForce(0, jumpForce, 0, ForceMode.Impulse);
        constantForceComponent.force = new Vector3(0, gravityInAir, 0);
        jumpSound.Play();
    }

    public static void SetGunUI(Gun gun)
    {
        Instance.magazineTxt.text = gun.currentMagSize.ToString();
        Instance.storageTxt.text = gun.currentReserveSize.ToString();
    }

    public void OnCollisionEnter(Collision collision)
    {
        if (collision.collider.CompareTag("Enemy"))
        {
            healthPoints -= 1;
            print($"Took damage...Current health: {healthPoints}");
            takeDamageSound.Play();
            Destroy(collision.collider.gameObject); //TODO: Delete this line
            //gameObject.transform.position += Vector3.forward * 10;
        }
        else
        {
            isOnGround = true;
            constantForceComponent.force = new Vector3(0, gravityOnGround, 0);
            jumpsLeft = jumpsAllowed;
        }
    }

    private void OnTriggerEnter(Collider collider)
    {
        if (collider.CompareTag("AmmoBox"))
        {
            maxAmmoSound.Play();
            Destroy(collider.gameObject);

            primaryGun?.GetComponent<Gun>().CollectMaxAmmo();
            secondaryGun?.GetComponent<Gun>().CollectMaxAmmo();
        }
        else if (collider.CompareTag("DoublePoints"))
        {
            doublePointsSound.Play();
            Destroy(collider.gameObject);

            if (doublePointsOn)
            {
                //if there is already a double points powerup running
                StopCoroutine("DoublePointsStart");
            }
            
            StartCoroutine("DoublePointsStart");
        }
        else if (collider.CompareTag("InstaKill"))
        {
            instaKillSound.Play();
            Destroy(collider.gameObject);

            if (instaKillOn)
            {
                //if there is already an instakill powerup running
                StopCoroutine("InstaKillStart");
            }
            
            StartCoroutine("InstaKillStart");
        }
    }

    public static void GiveMoney(int amount)
    {
        currentPoints += amount;
    }

    IEnumerator DoublePointsStart()
    {
        doublePointsOn = true;
        pointsPerEnemyHit = originalPointsPerEnemyHit * 2;
        pointsPerEnemyKill = originalPointsPerEnemyKill * 2;

        doublePointsRemainingTime = doublePointsDuration;
        for(int i = 1; i <= doublePointsDuration; i++)
        {
            yield return new WaitForSeconds(1);
            doublePointsRemainingTime--;
        }

        pointsPerEnemyHit = originalPointsPerEnemyHit;
        pointsPerEnemyKill = originalPointsPerEnemyKill;
        doublePointsOn = false;
    }

    IEnumerator InstaKillStart()
    {
        instaKillOn = true;
        instaKillRemainingTime = instaKillDuration;

        for (int i = 1; i <= instaKillDuration; i++)
        {
            yield return new WaitForSeconds(1);
            instaKillRemainingTime--;
        }

        instaKillOn = false;
    }
}