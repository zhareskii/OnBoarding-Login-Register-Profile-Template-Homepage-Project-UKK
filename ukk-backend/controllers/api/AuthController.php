<?php
namespace app\controllers\api;

use app\models\User;
use yii\rest\Controller;
use yii\web\Response;
use Yii;

class AuthController extends Controller
{
    public function init()
    {
        parent::init();
        
        // Set CORS headers
        Yii::$app->response->headers->set('Access-Control-Allow-Origin', '*');
        Yii::$app->response->headers->set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
        Yii::$app->response->headers->set('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept, Authorization, X-Requested-With');
        Yii::$app->response->headers->set('Access-Control-Allow-Credentials', 'true');
    }
    
    public function behaviors()
    {
        $behaviors = parent::behaviors();
        
        // Remove authentication
        unset($behaviors['authenticator']);
        
        // Set response format
        $behaviors['contentNegotiator']['formats']['text/html'] = Response::FORMAT_JSON;
        
        return $behaviors;
    }
    
    public function actionOptions($id = null)
    {
        Yii::$app->response->setStatusCode(200);
        Yii::$app->end();
    }
    
    public function actionLogin()
    {
        // Set CORS headers
        Yii::$app->response->headers->set('Access-Control-Allow-Origin', '*');
        Yii::$app->response->headers->set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
        Yii::$app->response->headers->set('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept, Authorization, X-Requested-With');
        
        Yii::$app->response->format = Response::FORMAT_JSON;
        
        $rawBody = Yii::$app->request->getRawBody();
        $loginData = json_decode($rawBody, true);
        
        if (!$loginData) {
            Yii::$app->response->statusCode = 400;
            return ['status' => 'error', 'message' => 'No data received'];
        }
        
        $username = $loginData['username'] ?? '';
        $password = $loginData['password'] ?? '';
        
        if (empty($username) || empty($password)) {
            Yii::$app->response->statusCode = 400;
            return ['status' => 'error', 'message' => 'Username dan password harus diisi'];
        }
        
        // Cari user berdasarkan username atau email
        $user = User::find()
            ->where(['username' => $username])
            ->orWhere(['email' => $username])
            ->one();
        
        if (!$user) {
            Yii::$app->response->statusCode = 401;
            return ['status' => 'error', 'message' => 'Username atau password salah'];
        }
        
        // Verifikasi password
        if (!password_verify($password, $user->password)) {
            Yii::$app->response->statusCode = 401;
            return ['status' => 'error', 'message' => 'Username atau password salah'];
        }
        
        // Login berhasil
        return [
            'status' => 'success',
            'message' => 'Login berhasil',
            'data' => [
                'id' => $user->id,
                'username' => $user->username,
                'email' => $user->email,
                'role' => $user->role,
                'created_at' => $user->created_at,
            ]
        ];
    }
}