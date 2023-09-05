using UnityEngine;

public class EnemyManager : MonoBehaviour
{
    public static EnemyManager Instance;
    public static GameObject target;

    [HideInInspector] public int health;
    public int speed = 5;
    public static int powerupPercentage = 10;

    private void Awake()
    {
        Instance = this;
    }

    public void Start()
    {
        target = GameObject.FindGameObjectWithTag("Player");
        health = Random.Range(50, 200);
    }

    void Update()
    {
        Move();
    }
    
    void Move()
    {
        Vector3 direction = (target.transform.position - transform.position).normalized;
        transform.LookAt(target.transform);
        transform.Translate(direction * speed * Time.deltaTime);
    }

    public void TakeDamage(int damage)
    {
        health -= damage;

        if (health <= 0)
        {
            Die();
        }
    }

    void Die()
    {
        if(Random.Range(1, 101) <= powerupPercentage)
        {
            GameObject powerup = Instantiate(GameManager.Instance.powerups[Random.Range(0, GameManager.Instance.powerups.Length)], GameObject.Find("EnemyDrops").transform);
            powerup.transform.position = transform.position;
        }

        Destroy(gameObject);
        PlayerStats.enemiesKilled++;

        PlayerManager.currentPoints += PlayerManager.pointsPerEnemyKill;
        PlayerStats.pointsEarned += PlayerManager.pointsPerEnemyKill;
    }
}
